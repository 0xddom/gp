module Gp
  module Problems
    module Regression
      module OOGP
        class MutableNumber
          attr_reader :value

          def initialize(value = 0)
            @value = value
            @initial = value
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

        class RegressionProblem < Gp::OOGPProblem
          def initialize(population_size, generations, size, prog_size, report)
            super population_size, generations, prog_size, report,
                  size, [:add, :mul, :nop, :assign, :reset, :sub]
            @size = size
            @samples = 10
          end

          def eval_indv(indv)
           
            indv.fitness.reset
            @samples.times {
              env = gen_env
              expected = function(env.vars)
              data = DataContainer.new 0
              indv.tree.eval_program env, data
              diff = (expected - data.get).abs
              unless diff.nan?
                indv.fitness.fitness += diff
              else
                indv.fitness.fitness += 1_000_000
              end
=begin             
              if indv.fitness.fitness.nan?
                puts ""
                puts "indv.fitness: #{indv.fitness}"
                puts "diff: #{diff}"
                puts "indv.tree: #{indv.tree}"
                puts "expected: #{expected}"
                puts "data.get: #{data.get}"
                puts "inputs: #{env.vars.map(&:value)}"
                puts "inputs before: #{env_copy.vars.map(&:value)}"
                byebug
              end
=end
              indv.fitness.hits += 1 if diff <= 0.01
            }
                      
          end

          def gen_env
            Environment.new(Array.new(@size) { MutableNumber.new rand })
          end

          def function(vars)
            vars.map { |v| v.value * v.value }.sum
          end
        end
      end
    end
  end
end
