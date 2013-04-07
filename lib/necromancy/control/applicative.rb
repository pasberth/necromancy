require 'necromancy'
require 'necromancy/control'

module Necromancy

  module Control::Applicative; extend Control

    # @note self :: a -> b -> c
    # @param [Object] callable a -> b
    # @return [Necromancy] a -> c
    def *(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.concat((#{str})); #{@necromancy}", @references.dup)
    end

    # @note self :: a -> b
    # @param [Object] callable a -> b -> c
    # @return [Necromancy] a -> c
    def **(callable)
      str = make_evaluable_string(callable)
      self.class.new(str, @references.dup).__Applicative_Astarisk(self)
    end

    # @note self :: a -> b
    # @param [Object] callable a -> _
    # @return [Necromancy] a -> b
    def <<(callable)
      self.class.new("args.pop; #{@necromancy}", @references.dup).__Applicative_Astarisk(callable)
    end

    # @note self :: a -> _
    # @param [Object] callable a -> b
    # @return [Necromancy] a -> b
    def >>(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.pop; #{str}", @references.dup).__Applicative_Astarisk(self)
    end

    alias __Applicative_Astarisk *
    protected :__Applicative_Astarisk
  end
end
