require 'slam'
require 'slam/ext'

module Slam

  module Category; extend Ext

    def >(callable)
      id = callable.to_proc.__id__
      str = make_evaluable_string(callable)
      necromancy = "args = (#@necromancy); #{str}"
      self.class.new(necromancy, [self])
    end

    def <(callable)
      str = make_evaluable_string(callable)
      necromancy = "args = #{str}; #@necromancy"
      self.class.new(necromancy, [self])
    end
  end
end
