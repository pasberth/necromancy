require 'necromancy'
require 'necromancy/control'
require 'necromancy/control/applicative'

module Necromancy

  module Control::Alternative; extend Control

    include Control::Applicative

    # Tests whether the result is empty or not.
    # If it is empty, {#empty?} returns the true, otherwise that returns the false.
    # By default, {#empty?} returns the true, if it is nil or false.
    def empty?(x, *xs)
      not x
    end

    :empty?.tap(&method(:protected))
    # protected :empty?

    # Applies the result of the callable into self unless that result is empty.
    # @see #empty?
    # @note self :: a -> b -> c
    # @param [Object] callable a -> b
    # @return [Necromancy] a -> c
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Alternative.new
    #   f = lambda(&N >> N.upcase)
    #   f.(nil) # => nil
    #   f.("foo") # => "FOO"
    def *(callable)
      str = make_evaluable_string(callable)
      necromancy = "self.empty?(*(xs = (#{str}))) ? xs : (args.concat(xs); #{@necromancy})"
      self.class.new(necromancy, @references.dup)
    end

    # Evaluates the callable, unless result of self is empty. otherwise that returns result of self.
    # @see #empty?
    # @note self :: a -> b
    # @param [Object] callable a -> b
    # @return [Necromancy] a -> b
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Alternative.new
    #   f = lambda(&N | ->(o){"foo"})
    #   f.(nil) # => "foo"
    #   f.("bar") # => "var"
    def |(callable)
      str = make_evaluable_string(callable)

      if @is_alternative_or
        exprs = [str, *@exprs]
      else
        exprs = [str, @necromancy]
      end

      necromancy = exprs.inject do |else_expr, cond_expr|
        "self.empty?(*(xs = (#{cond_expr}))) ? (#{else_expr}) : xs"
      end

      self.class.new(necromancy, @references.dup).instance_eval do
        @is_alternative_or = true
        @exprs = exprs
        self
      end
    end


    alias __Applicative_Astarisk *
    protected :__Applicative_Astarisk
  end
end
