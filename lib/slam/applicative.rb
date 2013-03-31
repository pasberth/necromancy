require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    refine Dunk do
      # Sequential application. 
      def *(callable) 
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { f.(x) if x = g.(*args, &block) }
        self.class.new(h)
      end
    end
  end

  module Alternative; extend Ext

    refine Dunk do

      def |(callable)
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { f.(*args, &block) || g.(*args, &block) }
        self.class.new(h)
      end
    end
  end
end
