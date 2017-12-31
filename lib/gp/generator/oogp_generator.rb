module Gp
  class OOGPGenerator
    def initialize(prog_size, n_instances, methods)
      @n_instances = n_instances
      @prog_size = prog_size
      @methods = methods
    end

    def create
      Gp::OOGP::Program.new(Array.new(@prog_size) { create_instruction })
    end

    def create_instruction
       [rand(@n_instances),
        @methods.sample,
        rand(@n_instances)]
    end
  end
end
