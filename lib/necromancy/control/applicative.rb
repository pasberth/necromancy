require 'necromancy'
require 'necromancy/control'

module Necromancy

  module Control::Applicative; extend Control

    # @note self :: a -> b -> c
    # @param [Object] callable a -> b
    # @return [Necromancy] a -> c
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Applicative.new
    #   f = lambda(&N.+ * N) # == ->(o) {o + o}
    #   f.(42) # => 84
    def *(callable)
      str = make_evaluable_string(callable)
      self.class.new("args << (#{str}); #{@necromancy}", @references.dup)
    end

    # A variant of {#*} with the arguments reversed. 
    # @note self :: a -> b
    # @param [Object] callable a -> b -> c
    # @return [Necromancy] a -> c
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Applicative.new
    #   f = lambda(&N ** :+) # == ->(o) {o + o}
    #   f.(42) # => 84
    def **(callable)
      str = make_evaluable_string(callable)
      self.class.new(str, @references.dup).__Applicative_Astarisk(self)
    end

    # Sequence actions, discarding the value of the callable.
    # @note self :: a -> b
    # @param [Object] callable a -> _
    # @return [Necromancy] a -> b
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Applicative.new
    #   f = lambda(&N.succ << N.pred) # == ->(o) {o.pred; o.succ}
    #   f.(42) # => 43
    def <<(callable)
      self.class.new("args.pop; #{@necromancy}", @references.dup).__Applicative_Astarisk(callable)
    end

    # Sequence actions, discarding the value of self.
    # @note self :: a -> _
    # @param [Object] callable a -> b
    # @return [Necromancy] a -> b
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Applicative.new
    #   f = lambda(&N.succ >> N.pred) # == ->(o) {o.succ; o.pred}
    #   f.(42) # => 41
    def >>(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.pop; #{str}", @references.dup).__Applicative_Astarisk(self)
    end

    alias __Applicative_Astarisk *
    protected :__Applicative_Astarisk
  end
end
