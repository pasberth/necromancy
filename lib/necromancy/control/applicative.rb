require 'necromancy'
require 'necromancy/control'

module Necromancy

  module Control::Applicative; extend Control

    def *(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.concat((#{str})); #{@necromancy}", @references.dup)
    end

    def **(callable)
      str = make_evaluable_string(callable)
      self.class.new(str, @references.dup) * self
    end

    def <<(callable)
      self.class.new("args.pop; #{@necromancy}", @references.dup) * callable
    end

    def >>(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.pop; #{str}", @references.dup) * self
    end
  end
end
