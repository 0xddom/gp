module Gp
  module OOGP
    class Method
      attr_reader :args
      attr_reader :name
      
      def initialize(name, args = [])
        @args = args
        @name = name
      end

      def arity
        @args.length
      end
    end

    class Type
      attr_reader :value

      def |(other)
        TypeList.new self, other
      end
    end
    
    class Interface < Type
      attr_reader :name
      attr_reader :imethods # To avoid name collisions

      def initialize(name, imethods = [])
        @name = name
        @imethods = imethods

        mthd :nop # NOP comes by default in the interfaces
      end

      def mthd(name, *args)
        imethods << Method.new(name, args)
      end

      def nop
      end
    end

    
    class Literal < Type
    end

    class Pointer < Type
      attr_reader :type
      attr_accessor :addr
      
      def initialize(type)
        @type = type
        @addr = 0
      end

      def self.[](t)
        new t
      end

      def get(env)
        env.vars[addr]
      end
    end

    P = Pointer

    class TypeList
      attr_reader :types
      
      def initialize(*types)
        @types = types
      end

      def |(type)
        @types << type
      end
    end
  end
end
