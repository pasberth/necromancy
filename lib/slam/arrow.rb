require 'slam'
require 'slam/ext'

module Slam

  module Arrow; extend Ext

    def &(callable)
      id = callable.to_proc.__id__
      str = make_evaluable_string(callable)
      necromancy = "[*(#{@necromancy}), *(#{str})]"
      self.class.new(necromancy, [self])
    end
  end
end
