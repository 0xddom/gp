require 'thor'
require 'gp'

trap("SIGINT") { exit! }

module Gp
  class CLI < Thor
    include Thor::Actions

    map %w(-v --version) => :version

    # Example CLI command. Uncomment the following to set it in action:
    #
    # desc 'commandname [param1|param2]', 'command description' 
    # method_option :countries, :type => :array
    # def commandname(someParam)
    #   # Do things
    # end

    desc 'version', 'gp version'
    def version
      puts Gp::VERSION
    end

    desc 'regression', 'gp regression'
    method_option :population, type: :numeric, default: Gp::Defaults::POPULATION
    method_option :generations, type: :numeric, default: Gp::Defaults::GENERATIONS
    method_option :size, type: :numeric, default: Gp::Defaults::SIZE
    method_option :depth, type: :numeric, default: Gp::Defaults::DEPTH
    method_option :koza, type: :boolean, default: false
    method_option :oogp, type: :boolean, default: false
    method_option :help, type: :boolean, default: false
    method_option :report, type: :string, default: Gp::Defaults::REPORT_PATH
    method_option :quiet, type: :boolean, default: false, aliases: '-q'
    method_option :verbose, type: :boolean, default: false, aliases: '-V'
    def regression
      if options[:help]
        invoke :help, ['regression']
      else
        Gp::Commands::Regression.new(options).execute
      end
    end

    desc 'evenparity', 'gp evenparity'
    method_option :population, type: :numeric, default: Gp::Defaults::POPULATION
    method_option :generations, type: :numeric, default: Gp::Defaults::GENERATIONS
    method_option :size, type: :numeric, default: Gp::Defaults::SIZE
    method_option :depth, type: :numeric, default: Gp::Defaults::DEPTH
    method_option :koza, type: :boolean, default: false
    method_option :oogp, type: :boolean, default: false
    method_option :help, type: :boolean, default: false
    method_option :report, type: :string, default: Gp::Defaults::REPORT_PATH
    method_option :quiet, type: :boolean, default: false, aliases: '-q'
    method_option :verbose, type: :boolean, default: false, aliases: '-V'
    def evenparity
      if options[:help]
        invoke :help, ['evenparity']
      else
        Gp::Commands::EvenParity.new(options).execute
      end
    end

    desc 'art', 'gp art'
    method_option :help, type: :boolean, default: false
    def art
      if options[:help]
        invoke :help, ['art']
      else
        Gp::Commands::Art.new(options).execute
      end
    end
  end
end
