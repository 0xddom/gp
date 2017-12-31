module Gp
  class DataContainer
    def initialize(val)
      set val
    end

    def get
      @val
    end

    def set(val)
      @val = val
    end

    def to_s
      @val.to_s
    end
  end
end

class Object
  def deep_clone
    Marshal.load(Marshal.dump(self))
  end
end
