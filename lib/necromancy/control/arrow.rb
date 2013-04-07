require 'necromancy'
require 'necromancy/control'
require 'necromancy/control/category'

module Necromancy

  module Control::Arrow; extend Control

    include Control::Category

    # @note self :: a -> b
    # @param [Object] callable a -> b'
    # @return [Necromancy] a -> (b, b')
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Arrow.new
    #   f = lambda(&N.upcase & :capitalize & :reverse) # == ->(o) { [o.upcase, o.capitalize, o.reverse] }
    #   f.("foo") # => ["FOO", "Foo", "oof"]
    def &(callable)
      str = make_evaluable_string(callable)
      necromancy = "(#{@necromancy}) + (#{str})"
      self.class.new(necromancy, @references.dup)
    end

    # @note self :: a -> b
    # @param [Object] callable a' -> b'
    # @return [Necromancy] (a, a') -> (b, b')
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Arrow.new
    #   f = lambda(&N.to_sym * N.to_f) # == ->(a, b) { [a.to_sym, b.to_f] }
    #   f.("x", 42) # => [:x, 42.0]
    def *(callable)
      str = make_evaluable_string(callable)
      necromancy = "stack << [] << args; args = stack[-1][0..-2]; stack[-2].concat((#{@necromancy})); args = [stack[-1][-1]]; stack[-2].concat((#{str})); args = stack.pop; stack.pop"
      self.class.new(necromancy, @references.dup)
    end
  end
end
