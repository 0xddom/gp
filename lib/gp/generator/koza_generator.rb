module Gp
  class KozaGenerator
    def initialize(fset, terminals, depth)
      @fset = fset
      @terminals = terminals
      @depth = depth
      
    end

    def create(curr_depth = 0)
      if curr_depth == 0 or (rand < 0.8 and curr_depth < @depth)
        @fset.sample.new { create curr_depth + 1 }
      else
        @terminals.sample
      end
    end
  end
end
