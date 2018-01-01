module Gp
  module Problems
    module Art
      include Gp::OOGP

      class RangedInt < Literal
        def initialize(range)
          @range = range
        end
        
        def value
          rand @range
        end

        def self.[](r)
          new r
        end
          
      end

      class Integer < Interface
        def initialize(value = 0)
          super :Integer
          @value = value
          @initial = value
          
          rng = RangedInt[-5_000_000_000..5_000_000_000]
          mthd :add, [rng | P[:Integer]]
          mthd :sub, [rng | P[:Integer]]
          mthd :mul, [rng | P[:Integer]]
          mthd :assign, [rng | P[:Integer]]
          mthd :reset
          mthd :inc
          mthd :dec
        end

        def add(o)
          @value += o.value
        end
        
        def sub(o)
          @value -= o.value
        end
        
        def mul(o)
          @value *= o.value
        end

        def inc
          @value += 1
        end

        def dec
          @value -= 1
        end
        
        def assign(o)
          @value = o.value
        end
        
        def reset
          @value = @initial
        end
      end
      
      class DrawingSurfaceWrapper < Interface
        def initialize(surface)
          super :DrawingContextWrapper
          @dctx = Cairo::Context.new surface
          @value = surface
          @surface = surface

          @last_red = 0.0
          @last_green = 0.0
          @last_blue = 0.0
          @last_alpha = 0.0

          @current_x = 0.0
          @current_y = 0.0

          r = RangedInt[0..255]
          width_range = RangedInt[0..surface.width]
          height_range = RangedInt[0..surface.height]
          mthd :set_red, r | P[:Integer]
          mthd :set_green, r | P[:Integer]
          mthd :set_blue, r | P[:Integer]
          mthd :set_alpha, r | P[:Integer]
          mthd :set_rgb, r | P[:Integer], r | P[:Integer], r | P[:Integer]
          mthd :set_rgba, r | P[:Integer], r | P[:Integer], r | P[:Integer], r | P[:Integer]
          mthd :reset_color
          mthd :move_x, width_range | P[:Integer]
          mthd :move_y, height_range | P[:Integer]
          mthd :move_to, widht_range | P[:Integer], height_range | P[:Integer]
          mthd :reset_pos
          mthd :line_to, width_range | P[:Integer], height_range | P[:Integer]
        end

        def set_red(n)
          @last_red = (n % 256) / 255.0
          @dctx.set_source_rgba @last_red, @last_green, @last_blue, @last_alpha
        end

        def set_green(n)
          @last_green = (n % 256) / 255.0
          @dctx.set_source_rgba @last_red, @last_green, @last_blue, @last_alpha
        end

        def set_blue(n)
          @last_blue = (n % 256) / 255.0
          @dctx.set_source_rgba @last_red, @last_green, @last_blue, @last_alpha
        end

        def set_alpha(n)
          @last_alpha = (n % 256) / 255.0
          @dctx.set_source_rgba @last_red, @last_green, @last_blue, @last_alpha
        end

        def set_rbg(r, g, b)
          @last_red = (r % 256) / 255.0
          @last_green = (g % 256) / 255.0
          @last_blue = (b % 256) / 255.0

          @dctx.set_source_rgba @last_red, @last_green, @last_blue, @last_alpha
        end

        def set_rgba(r, g, b, a)
          @last_red = (r % 256) / 255.0
          @last_green = (g % 256) / 255.0
          @last_blue = (b % 256) / 255.0
          @last_alpha = (a % 256) / 255.0
          @dctx.set_source_rgba @last_red, @last_green, @last_blue, @last_alpha
        end

        def reset_color
          @last_red = 0.0
          @last_green = 0.0
          @last_blue = 0.0
          @last_alpha = 0.0
        end

        def move_x(x)
          @current_x = x
          @dctx.move_to @current_x, @current_y
        end

        def move_y(y)
          @current_y = y
          @dctx.move_to @current_x, @current_y
        end

        def move_to(x, y)
          @current_x = x
          @current_y = y
          @dctx.move_to @current_x, @current_y
        end

        def reset_pos
          @current_x = 0
          @current_y = 0
        end

        def line_to(x, y)
          @dctx.line_to x, y
        end
      end
    end
  end
end
