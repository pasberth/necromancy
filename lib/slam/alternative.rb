require 'slam'
require 'slam/ext'

module Slam

  module Alternative; extend Ext

    using Applicative

    refine Dunk do

      def *(callable) 
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { (x = g.(*args, &block)) ? f.(*args, x, &block) : x }
        self.class.new(h)
      end

      def |(callable)
        f = to_proc
        g = callable.to_proc
        h = ->(*args, &block) { f.(*args, &block) || g.(*args, &block) }
        self.class.new(h)
      end
    end
  end
end
