require 'slam'
require 'slam/ext'

module Slam

  module Alternative; extend Ext

    using Applicative

    refine Dunk do

      def *(callable) 
        f = to_proc
        g = callable.to_proc
        h = ->(o, *args, &block) { (x = g.(o, &block)) ? f.(o, *args, x, &block) : x }
        self.class.new(h)
      end

      def |(callable)
        f = to_proc
        g = callable.to_proc
        h = ->(o, *args, &block) { f.(o, *args, &block) || g.(o, &block) }
        self.class.new(h)
      end
    end
  end
end
