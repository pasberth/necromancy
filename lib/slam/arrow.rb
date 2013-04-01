require 'slam'
require 'slam/ext'

module Slam

  module Arrow; extend Ext

    refine Dunk do

      def &(callable)
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { [f.(*args, &block), g.(*args, &block)] }
        self.class.new(h)
      end
    end
  end
end
