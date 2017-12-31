module Gp
  module OOGP
    class Program
      def initialize(instructions)
        @instructions = instructions
      end
      
      def eval_program(env, data)
        @instructions.each do |c, m, a|
          env.vars[c].send(m, env.vars[a])
        end
        data.set env.vars[0].value
      end

      def length
        @instructions.length
      end

      def [](i)
        @instructions[i]
      end

      def to_s
        @instructions.reject {|_, m, _| m == :nop}.map {|c, m, a| "o#{c}.#{m}(o#{a})"}.join '; '
      end

      def mutate(generator)
        if rand < 0.4
          new_ins = @instructions.deep_clone
          new_ins[rand new_ins.length] = generator.create_instruction
          Program.new new_ins
        else
          deep_clone
        end
      end
    end
  end
end
