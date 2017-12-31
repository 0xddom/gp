module Gp
  module Koza
    class NonTerminalNode
      attr_accessor :children

      def initialize(arity, sym, children = [])
        @arity = arity
        @sym = sym
        if block_given?
          @children = Array.new(arity, yield)
        else
          @chidren = children
        end
      end

      def to_s
        "(#{@sym.to_s} #{children.map(&:to_s).join ' '})"
      end

      def non_terminals
        [self] + children.map(&:non_terminals).flatten
      end

      def crossover(o)
        if rand < 0.8
          new_tree = self.class.new { nil }
          new_tree.children = children.deep_clone
          new_tree.children[rand % new_tree.children.length] = o
          new_tree
        else
          o
        end
      end

      def mutate(generator, depth=0)
        if rand < 0.2
          generator.create depth
        else
          new_me = deep_clone
          new_me.children[rand new_me.children.length].mutate(generator, depth+1)
          new_me
        end
      end

      def self.new_with_children(children)
        
        instance = self.new {children}
        #instance.children.flatten!
        instance
      end

      alias :inspect :to_s
    end

    class TerminalNode
      alias :inspect :to_s

      def non_terminals
        []
      end

      def crossover(o)
        o
      end

      def mutate(generator, depth=0)
        if rand < 0.2
          generator.create depth
        else
          deep_clone
        end
      end
    end
  end
end
