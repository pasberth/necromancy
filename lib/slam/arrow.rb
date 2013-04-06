require 'slam'
require 'slam/ext'
require 'slam/category'

module Slam

  module Arrow; extend Ext

    include Category

    def &(callable)
      str = make_evaluable_string(callable)
      necromancy = "(#{@necromancy}) + (#{str})"
      self.class.new(necromancy, @references.dup)
    end

    def *(callable)
      str = make_evaluable_string(callable)
      necromancy = "stack << [] << args; args = stack[-1][0..-2]; stack[-2].concat((#{@necromancy})); args = stack[-1][1..-1]; stack[-2].concat((#{str})); args = stack.pop; stack.pop"
      self.class.new(necromancy, @references.dup)
    end
  end
end
