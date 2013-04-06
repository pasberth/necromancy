require 'slam'
require 'slam/ext'

module Slam

  module Category; extend Ext

    def >(callable)
      id = callable.to_proc.__id__
      necromancy = "[*::ObjectSpace._id2ref(#{id}).(*(#@necromancy))]"
      self.class.new(necromancy)
    end

    def <(callable)
      id = callable.to_proc.__id__
      necromancy = "args = [::ObjectSpace._id2ref(#{id}).(*args)]; #@necromancy"
      self.class.new(necromancy)
    end
  end
end
