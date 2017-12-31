module Gp
  ##
  # Take a population a from a sample of size will return the one with best fitness
  class Tournament
    def initialize(population, size=7)
      @population = population
      @size = size
    end

    def select
      @population.sample(@size).max { |i1, i2| i1.fitness <=> i2.fitness }
    end
  end
end
