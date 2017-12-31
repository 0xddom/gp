module Gp
  class Report
    QUIET = 'quiet'
    NORMAL = 'normal'
    VERBOSE = 'verbose'
    
    def initialize(path, verbosity)
      @fd = File.open path, 'w'
      @verbosity = verbosity
    end

    def report(curr_gen, max_gen, best)
      if @verbosity == VERBOSE
        puts "Generation #{curr_gen}/#{max_gen}"
      
        puts "Best fitness=#{best.fitness.adjusted} hits=#{best.fitness.hits}"
        puts "Code: #{best.tree}"
        puts "-"*50
      elsif @verbosity == NORMAL
        print "."
      end

      @fd.puts([curr_gen, best.fitness.adjusted].join "\t")
    end
  
    def final_report(generations, best)
      unless @verbosity == QUIET
        puts ""
        puts "Final report:"
        puts "# Generations: #{generations}"
        puts "Best fitness=#{best.fitness.adjusted} hits=#{best.fitness.hits}"
        puts "Code: #{best.tree}"
        puts ""
      end
      @fd.close
    end
  end
end
