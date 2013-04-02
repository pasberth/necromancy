require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    refine Dunk do

      def **(callable)
        self.class.new(callable) * self
      end

      def <(callable)
        self.class.new(->(g, *xs) {->(x, y){g.(x)}}) * self * callable
      end

      def >(callable)
        self.class.new(->(g, *xs) {->(x, y){g.(y)}}) * self * callable
      end
    end
  end
end
