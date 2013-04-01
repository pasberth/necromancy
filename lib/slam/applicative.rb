require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    using Category

    refine Dunk do

      def **(callable)
        self.class.new(callable) * self
      end

      def <(callable)
        self.class.new(->(x, y) {x}) * self * callable
      end

      def >(callable)
        self.class.new(->(x, y) {y}) * self * callable
      end
    end
  end
end
