require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    refine Dunk do

      def **(callable)
        self.class.new(callable) * self
      end

      def <(callable)
        self.class.new(->(o, x, y) {x}) * self * callable
      end

      def >(callable)
        self.class.new(->(o, x, y) {y}) * self * callable
      end
    end
  end
end
