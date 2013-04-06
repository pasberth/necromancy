require 'slam'
require 'slam/ext'

module Slam

  module Arrow; extend Ext

    def &(callable)
      str = make_evaluable_string(callable)
      necromancy = "(#{@necromancy}) + (#{str})"
      self.class.new(necromancy, @references.dup)
    end
  end
end
