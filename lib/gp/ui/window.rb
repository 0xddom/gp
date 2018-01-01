# coding: utf-8
module Gp
  module UI
    class MainWindow < Gtk::Builder

      def initialize
        super

        init_ui
      end

      def on_new_evo_run(options)
        width, height = load_original_image options[:image]
        setup_initial_canvas width, height
      end
      
      private
      def on_quit(e)
        puts "Exiting..."
        Gtk.main_quit
      end

      def on_load_new_image(e)
        NewEvoForm.new self
      end

      def init_ui
        add_from_file File.join(File.dirname(__FILE__), 'window.ui')

        @main_window = get_object :main_window
        @menu_close_button = get_object :close_button
        @original_image = get_object :original_image
        @new_run_button = get_object :new_run_button
        @best_indv_image = get_object :best_indv
       

        @main_window.show
        @main_window.signal_connect :destroy, &method(:on_quit)
        @menu_close_button.signal_connect :activate, &method(:on_quit)
        @new_run_button.signal_connect :clicked, &method(:on_load_new_image)
      end

      def load_original_image(path)
        @original_image.hide
        @original_image.set_from_file path
        desired_width = [@original_image.pixbuf.width, Gp::Defaults::MAX_WIDTH].min
        desired_height = [@original_image.pixbuf.height, Gp::Defaults::MAX_HEIGHT].min
        new_pixbuf = @original_image.pixbuf.scale_simple(desired_width, desired_height,
                                            GdkPixbuf::InterpType::BILINEAR)
        @original_image.from_pixbuf = new_pixbuf
        @original_image.show
        [desired_width, desired_height]
      end

      def setup_initial_canvas(width, height)
        surface = Cairo::ImageSurface.new :ARGB32, width, height
        context = Cairo::Context.new surface
        context.set_source_rgba 0.8, 0.8, 0.8, 1
        context.rectangle 0, 0, width, height
        context.fill.stroke
        @best_indv_image.from_surface = surface
      end
    end
  end
end
