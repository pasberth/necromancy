require 'necromancy'
require 'necromancy/control'

module Necromancy

  module Control::Category; extend Control

    # Left-to-right composition.
    # @note self :: a -> b
    # @param [Object] callable b -> c
    # @return [Necromancy] a -> c
    # @example
    #   lambda(&N.to_i > N * 2).('42').
    #     should == '42'.to_i * 2
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
    #   lambda(&N.to_i < N * 2).('42').
    #     should == ('42' * 2).to_i
    def <(callable)
      str = make_evaluable_string(callable)
      necromancy = "args = (#{str}); #{@necromancy}"
      self.class.new(necromancy, @references.dup)
    end
  end
end
