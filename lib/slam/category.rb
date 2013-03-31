require 'slam'
require 'slam/ext'

module Slam

  module Category; extend Ext

    refine Dunk do

      def >>(callable)
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { g.(f.(*args, &block)) }
        self.class.new(h)
      end
    end
  end
end
