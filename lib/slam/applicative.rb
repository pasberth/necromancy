require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    refine Dunk do
      # Sequential application. 
      def *(callable) 
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { f.(*args, x, &block) if x = g.() }
        self.class.new(h)
      end
    end
  end
end