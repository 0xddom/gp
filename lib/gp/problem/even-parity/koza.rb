module Gp
  module Problems
    module EvenParity
      module Koza
        class And < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :and, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set(tmp && data.get)
          end
        end

        class Or < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :or, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set(tmp || data.get)
          end
        end

        class Xor < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :xor, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set(tmp || data.get && (!(tmp && data.get)))
          end
        end

        class Not < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 1, :not, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data

            data.set(!data.get)
          end
        end

        class Iff < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :iff, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set(!(tmp || data.get && (!(tmp && data.get))))
          end
        end
        
        class If < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :if, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set(!tmp || data.get)
          end
        end

        class BoolVar < Gp::Koza::TerminalNode
          def initialize(idx)
            @idx = idx
          end

          def eval_node(env, data)
            data.set env.vars[@idx]
          end

          def to_s
            "n#{@idx}"
          end
        end

        class EvenParityProblem < Gp::KozaProblem
          def initialize(population_size, generations, size, depth, report)
            super(population_size, generations, depth, report,
                  [And, Or, Xor, Not],
                  Array.new(size) { |i| BoolVar.new i }
                 )
            @size = size
            @samples = 10
          end

          def eval_indv(indv)
           
            indv.fitness.reset
            @samples.times {
              env = gen_env
              expected = function(env.vars)
              data = DataContainer.new 0
              indv.tree.eval_node env, data
              #diff = (expected - data.get).abs
              #indv.fitness.fitness += diff
              #indv.fitness.hits += 1 if diff <= 0.01
            }
                      
          end

          def gen_env
            #Environment.new(Array.new(@size) { rand })
          end

          def function(vars)
            #vars.map { |v| v*v }.sum
          end
        end
      end
    end
  end
end
      
