require 'slam'
require 'slam/ext'

module Slam

  module Alternative; extend Ext

    using Applicative

    refine Dunk do

      def empty?(alternative)
        !alternative
      end

      protected :empty?

      def *(callable) 
        f = to_proc
        g = callable.to_proc
        h = ->(o, *args, &block) { empty?(x = g.(o, &block)) ? x : f.(o, x, *args, &block) }
        self.class.new(h)
      end

      def |(callable)
        f = to_proc
        g = callable.to_proc
        h = ->(o, *args, &block) { empty?(x = f.(o, *args, &block)) ? g.(o, &block) : x }
        self.class.new(h)
      end
    end
  end
end
