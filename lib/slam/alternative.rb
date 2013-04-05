require 'slam'
require 'slam/ext'

module Slam

  module Alternative; extend Ext

    include Slam::Applicative

    def empty?(alternative)
      !alternative
    end

    protected :empty?

    def *(callable)
      f = ->(g, *xs, &block; f) { f = @callable.(->(x){x}, *xs, &block); empty?(x = callable.to_proc.(*xs, &block)) ? ->(*ys) { g.(x) } : ->(*ys) { g.(f.(x, *ys)) } }
      self.class.new(f)
    end

    def |(callable)
      f = ->(g, *xs, &block) { ->(*ys) { empty?(x = to_proc.(*xs, *ys, &block)) ? g.(callable.to_proc.(*xs, *ys, &block)) : g.(x) } }
      self.class.new(f)
    end
  end
end
