require 'necromancy'
require 'necromancy/control'
require 'necromancy/control/applicative'

module Necromancy

  module Control::Alternative; extend Control

    include Control::Applicative

    def empty?(*xs)
      xs.none?
    end

    protected :empty?

    def *(callable) 
      str = make_evaluable_string(callable)
      necromancy = "self.empty?(*(xs = (#{str}))) ? xs : (args.concat(xs); #{@necromancy})"
      self.class.new(necromancy, @references.dup)
    end

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
