module Gp
  module Problems
    module EvenParity
      module OOGP
        class MutableBool
          attr_reader :value

          def initialize(value = false)
            @value = value
            @initial = value
          end

          def and(o)
            @value &= o.value
          end

          def or(o)
            @value |= o.value
          end

          def xor(o)
            @value = @value || o.value && (!(@value && o.value))
          end

          def not_(_)
            @value = !@value
          end

          def if(o)
            @value = !@value || o.value
          end

          def iff(o)
            xor o
            not_ o
          end

          def nop(_)
          end

          def assign(o)
            @value = o.value
          end

          def reset(_)
            @value = @initial
          end

          def to_s
            @value.to_s
          end
        end

        class EvenParityProblem < Gp::OOGPProblem
          def initialize(population_size, generations, size, prog_size, report)
            super population_size, generations, prog_size, report,
                  size, [:and, :or, :xor, :not_, :if, :iff, :nop, :assign, :reset]
            @size = 2**size
            @inputs = Array.new(@size) 
            @outputs = Array.new(@size)

            for i in 0..@size
              @inputs[i] = Array.new(size)
              value = i
              dividor = @size
              parity = true
              for j in 0..size
                dividor /= 2
                if value >= dividor
                  @inputs[i][j] = true
                  parity = !parity
                  value -= dividor
                else
                  @inputs[i][j] = false
                end
              end
              @outputs[i] = parity
            end
          end

          def eval_indv(indv)
           
            indv.fitness.reset
            indv.fitness.fitness = @size
            @inputs.each_index { |i|
              env = gen_env i
              expected = @outputs[i]
              data = DataContainer.new false
              indv.tree.eval_program env, data
              if data.get == expected
                indv.fitness.fitness -= 1
                indv.fitness.hits += 1
              end
            }
          end

          def gen_env(i)
            Environment.new(@inputs[i].map {|e| MutableBool.new e})
          end
        end
      end
    end
  end
end
