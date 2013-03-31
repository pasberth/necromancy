module Slam

  class Dunk < BasicObject

    IDENTITY = ->(x) { x }

    protected *instance_methods
    protected

    def initialize(callable = IDENTITY, *args, &block)
      @callable = callable.to_proc
      @args = args
      @block = block
    end

    def method_missing(name, *args, &block)
      self >> self.class.new(name, *args, &block)
    end

    def to_proc
      ->(*args, &block) { @callable.(*args, *@args, &(block||@block)) }
    end

    def class
      @class ||= (class << self; self end).superclass
    end

    def >>(callable)
      f = to_proc
      g = callable.to_proc
      h = ->(*args, &block) { g.(f.(*args, &block)) }
      self.class.new(h)
    end
  end
end
