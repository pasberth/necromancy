module Slam

  class Dunk < BasicObject

    protected *instance_methods
    protected

    def initialize(callable = nil, *args, &block)
      @callable = callable.to_proc unless callable.nil?
      @args = args
      @block = block
    end

    def compose(callable, *args, &block)
      if @callable.nil?
        self.class.new(callable, *args, &block)
      else
        f = to_proc
        g = self.class.new(callable, *args, &block).to_proc
        h = ->(*args, &block) { g.(f.(*args, &block)) }
        self.class.new(h)
      end
    end

    alias method_missing compose

    def to_proc
      if @callable.nil?
        ->(x){x}
      else
        ->(*args, &block) { @callable.(*args, *@args, &(block||@block)) }
      end
    end

    def class
      @class ||= (class << self; self end).superclass
    end
  end
end
