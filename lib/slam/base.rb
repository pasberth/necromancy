module Slam

  class Base < BasicObject

    IDENTITY = ->(x) { x }

    protected *instance_methods
    protected

    def initialize(callable = IDENTITY, *args, &block)
      @callable = callable.to_proc
      @args = args
      @block = block
    end

    def method_missing(name, *args, &block)
        f = to_proc
        g = self.class.new(name, *args, &block).to_proc
        h = ->(*args, &block) { g.(f.(*args, &block)) }
        self.class.new(h)
    end

    def to_proc
      ->(*args, &block) { @callable.(*args, *@args, &(block||@block)) }
    end

    def class
      @class ||= (class << self; self end).superclass
    end
  end
end
