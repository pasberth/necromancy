require 'necromancy'
require 'necromancy/control'

module Necromancy

  module Category; extend Control

    def >(callable)
      str = make_evaluable_string(callable)
      necromancy = "args = (#{@necromancy}); #{str}"
      self.class.new(necromancy, @references.dup)
    end

    def <(callable)
      str = make_evaluable_string(callable)
      necromancy = "args = (#{str}); #{@necromancy}"
      self.class.new(necromancy, @references.dup)
    end
  end
end
