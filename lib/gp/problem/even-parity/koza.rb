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
                  [And, Or, Xor, Not, If, Iff],
                  Array.new(size) { |i| BoolVar.new i }
                 )
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
              indv.tree.eval_node env, data
              if data.get == expected
                indv.fitness.fitness -= 1
                indv.fitness.hits += 1
              end
            }
          end

          def gen_env(i)
            Environment.new(@inputs[i])
          end
        end
      end
    end
  end
end
      
