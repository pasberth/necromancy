require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    refine Dunk do
      # Sequential application. 
      def *(callable) 
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { (x = g.(*args, &block)) ? f.(*args, x, &block) : x }
        self.class.new(h)
      end

      def **(callable)
        f = callable.to_proc
        g = to_proc
        h = ->(*args, &block) { (x = g.(*args, &block)) ? f.(*args, x, &block) : x }
        self.class.new(h)
    end
  end
end
