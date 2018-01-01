module Gp
  class Problem
    attr_accessor :population_size
    attr_accessor :generations
    attr_accessor :population

    def initialize(population_size, generations, generator, report, crossover)
      @population_size = population_size
      @generations = generations
      @generator = generator
      @report = report
      @population = Array.new(@population_size) { Individual.new @generator.create }
      @crossover = crossover
    end

    def eval_indv(_)
      raise 'Abstract method!'
    end

    def evolve
      curr_gen = 0
      goal_reached = false
      while curr_gen < generations and not goal_reached
        
        population.each do |indv|
          eval_indv indv unless indv.evaluated?
          indv.evaluated
        end

        best = population.max { |i,j| i.fitness <=> j.fitness }
        @report.report curr_gen, generations, best
        goal_reached = best.fitness.adjusted > 0.95
        
        curr_gen += 1
        new_generation if curr_gen < generations and not goal_reached
      end

      @report.final_report curr_gen, best
    end

    private
    
    def new_generation
      t = Tournament.new population
      new_individuals = Array.new(population_size/2) { @crossover.new(t.select, t.select).crossover }

      while not new_individuals.empty?
        i = (0..population_size-1).to_a.sample
        if rand < population[i].fitness.adjusted
          population[i] = new_individuals.pop
        end
      end
      
      population.each do |indv|
        if rand < 0.4
          indv.tree = indv.tree.mutate @generator
          indv.fitness.reset
          indv.evaluated = false
        end
      end
    end
  end

  class KozaProblem < Problem   
    def initialize(population_size, generations, depth, report, func_set, terminals)
      super population_size, generations,
            Gp::KozaGenerator.new(func_set, terminals, depth), report, KozaCrossover
    end
  end

  class OOGPProblem < Problem
    def initialize(population_size, generations, prog_size, report, n_instances, methods)
      super population_size, generations,
            Gp::OOGPGenerator.new(prog_size, n_instances, methods), report, OOGPCrossover
    end
  end
end
