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
      self.class.new(str, @references.dup).__Applicative_Astarisk(self)
    end

    def <<(callable)
      self.class.new("args.pop; #{@necromancy}", @references.dup).__Applicative_Astarisk(callable)
    end

    def >>(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.pop; #{str}", @references.dup).__Applicative_Astarisk(self)
    end

    alias __Applicative_Astarisk *
    protected :__Applicative_Astarisk
  end
end
