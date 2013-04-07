require 'necromancy'
require 'necromancy/control'

module Necromancy

  module Control::Category; extend Control

    # Left-to-right composition.
    # @note self :: a -> b
    # @param [Object] callable b -> c
    # @return [Necromancy] a -> c
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Category.new
    #   f = lambda(&N.to_i > N * 2) # == ->(o) { o.to_i * 2 }
    #   f.('42') # => 84
    def >(callable)
      str = make_evaluable_string(callable)
      necromancy = "args = (#{@necromancy}); #{str}"
      self.class.new(necromancy, @references.dup)
    end

    # Right-to-left composition
    # @note self :: b -> c
    # @param [Object] callable a -> b
    # @return [Necromancy] a -> c
    # @example
    #   require 'necromancy'
    #   N = Necromancy.Category.new
    #   f = lambda(&N.to_i < N * 2) # == ->(o) { (o * 2).to_i }
    #   f.('42') # => 4242
    def <(callable)
      str = make_evaluable_string(callable)
      necromancy = "args = (#{str}); #{@necromancy}"
      self.class.new(necromancy, @references.dup)
    end
  end
end
