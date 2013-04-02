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
        f = ->(g, *args, &block) { empty?(x = callable.to_proc.(*args, &block)) ? g.(x) : @callable.(g, *args, x, &block) }
        self.class.new(f)
      end

      def |(callable)
        f = ->(g, *args, &block) { empty?(x = to_proc.(*args, &block)) ? g.(callable.to_proc.(*args, &block)) : g.(x) }
        self.class.new(f)
      end
    end
  end
end
