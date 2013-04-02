module Slam

  class Dunk < BasicObject

    IDENTITY = ->(g, *args, &block) { g.(*args, &block) }

    protected *instance_methods
    protected

    attr_reader :callable
    attr_reader :args
    attr_reader :block

    def initialize(callable = IDENTITY, *args, &block)
      @callable = callable.to_proc
      @args = args
      @block = block
    end

    def method_missing(name, *args, &block)
      f = ->(*_args) { name.to_proc.(*_args, *args, &block) }
      f_ = ->(g, *args, &block) { g.(@callable.(f, *args, &block)) }
      self.class.new(f_)
    end

    def to_proc
      ->(*args, &block) { @callable.(->(*xs){xs.size==1 ? xs[0] : xs}, *args, *@args, &(block||@block)) }
    end

    def class
      @class ||= (class << self; self end).superclass
    end
  end
end
