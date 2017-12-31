module Gp
  module Problems
    module Regression
      module Koza
        class Add < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :+, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set tmp + data.get
          end
        end

        class Sub < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :-, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set tmp - data.get
          end
        end

        class Mul < Gp::Koza::NonTerminalNode
          def initialize(&block)
            super 2, :*, &block
          end

          def eval_node(env, data)
            children[0].eval_node env, data
            tmp = data.get

            children[1].eval_node env, data
            data.set tmp * data.get
          end
        end

        class Var < Gp::Koza::TerminalNode
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

        class RegressionProblem < Gp::KozaProblem
          def initialize(population_size, generations, size, depth, report)
            super(population_size, generations, depth, report,
                  [Gp::Problems::Regression::Koza::Add,
                   Gp::Problems::Regression::Koza::Sub,
                   Gp::Problems::Regression::Koza::Mul],
                  Array.new(size) { |i| Gp::Problems::Regression::Koza::Var.new i }
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
              diff = (expected - data.get).abs
              indv.fitness.fitness += diff
              indv.fitness.hits += 1 if diff <= 0.01
            }
                      
          end

          def gen_env
            Environment.new(Array.new(@size) { rand })
          end

          def function(vars)
            vars.map { |v| v*v }.sum
          end
        end
      end
    end
  end
end
