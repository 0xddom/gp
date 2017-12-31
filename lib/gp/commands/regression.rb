module Gp
  module Commands
    class Regression
      def initialize(options)
        @options = options
      end
      
      def execute
        population = @options[:population]
        generations = @options[:generations]
        size = @options[:size]
        depth = @options[:depth]
        report_path = @options[:report]
        verbosity = if @options[:quiet]
                      Gp::Report::QUIET
                    elsif @options[:verbose]
                      Gp::Report::VERBOSE
                    else
                      Gp::Report::NORMAL
                    end
        koza = @options[:koza]
        oogp = @options[:oogp]

        if koza
          koza_problem = Gp::Problems::Regression::Koza::RegressionProblem.new(
            population, generations, size, depth, Gp::Report.new(report_path, verbosity))
          koza_problem.evolve
        elsif oogp
          oogp_problem = Gp::Problems::Regression::OOGP::RegressionProblem.new(
            population, generations, size, depth, Gp::Report.new(report_path, verbosity))
          oogp_problem.evolve
        else
          puts "Select either --koza or --oogp"
        end
      end
    end
  end
end
