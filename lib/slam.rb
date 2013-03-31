module Slam

  class Base < BasicObject

    private *instance_methods
  end

  class Dunk < Base

    private

    def method_missing(name, *args, &block)
      Compose.new(name, *args, &block)
    end
  end

  class Compose < Base

    private

    def initialize(callable, *args, &block)
      @callable = callable.to_proc
      @args = args
      @block = block
    end

    def method_missing(name, *args, &block)
      f = to_proc
      g = Compose.new(name, *args, &block).to_proc
      h = ->(*args, &block) { g.(f.(*args, &block)) }
      Compose.new(h)
    end

    def to_proc
      ->(*args, &block) { @callable.(*args, *@args, &(block||@block)) }
    end

    protected :to_proc
  end
end
