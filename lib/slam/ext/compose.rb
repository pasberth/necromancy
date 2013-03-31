require 'slam'
require 'slam/ext'

module Slam

  module Ext::Compose; extend Ext

    refine Dunk do

      def >>(callable)
        Compose.new(callable.to_proc)
      end
    end

    refine ::Slam::Compose do

      def >>(callable)
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { g.(f.(*args, &block)) }
        Compose.new(h)
      end
    end
  end
end
