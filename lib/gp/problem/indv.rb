module Gp
  class KozaFitness
    include Comparable
    
    attr_accessor :hits, :fitness

    def initialize
      reset
    end

    def reset
      @hits = 0
      @fitness = 0
    end

    def <=>(o)
      if fitness == o.fitness
        hits <=> o.hits
      else
        -(fitness <=> o.fitness)
      end
    end

    def inspect
      "(#{fitness}, #{hits})"
    end

    alias :to_s :inspect

    def adjusted
      1 / (1 + fitness)
    end
  end
  
  class Individual
    attr_accessor :tree
    attr_reader :fitness
    attr_writer :evaluated
    
    def initialize(tree, fitness = KozaFitness.new)
      @tree = tree
      @evaluated = false
      @fitness = fitness
    end
    
    def evaluated
      @evaluated = true
    end

    def evaluated?
      @evaluated
    end

    def to_s
      "Individual { tree=#{tree} fitness=#{fitness} }"
    end
  end
end
