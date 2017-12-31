module Gp
  class Environment
    attr_reader :vars
    
    def initialize(vars)
      @vars = vars
    end

    def to_s
      "Env { vars=#{vars.map(&:to_s)} }"
    end
  end
end
