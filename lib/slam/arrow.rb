require 'slam'
require 'slam/ext'

module Slam

  module Arrow; extend Ext

    def &(callable)
      id = callable.to_proc.__id__
      necromancy = "[*(#@necromancy), ::ObjectSpace._id2ref(#{id}).(*args)]"
      self.class.new(necromancy, [self])
    end
  end
end
