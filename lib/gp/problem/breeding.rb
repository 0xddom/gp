module Gp
  class KozaCrossover
    def initialize(parent_a, parent_b)
      @parent_a = parent_a.tree.deep_clone
      @parent_b = parent_b.tree.deep_clone 
    end

    def crossover
      node_a = get_nodes(@parent_a).sample
      node_b = get_nodes(@parent_b).sample

      new_tree = if rand < 0.5
                   node_a.crossover(node_b)
                 else
                   node_b.crossover(node_a)
                 end
      Gp::Individual.new new_tree
    end

    private
    def get_nodes(parent)
      nodes = parent.non_terminals
      nodes = [parent] if nodes.empty?
      nodes
    end
  end

  class OOGPCrossover
    def initialize(parent_a, parent_b)
      @parent_a = parent_a.tree
      @parent_b = parent_b.tree
    end

    def crossover
      # Assuming same size
      Individual.new Gp::OOGP::Program.new(Array.new(@parent_a.length) { |i|
        if rand < 0.5
          @parent_a[i] || @parent_b[i] # Fallback in case of nil
        else
          @parent_b[i] || @parent_a[i]
        end
      })
    end
  end
end
