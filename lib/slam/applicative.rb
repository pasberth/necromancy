require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    refine Dunk do

      def **(callable)
        self.class.new(callable) * self
      end

      def <(callable)
        self.class.new(->(g, o, x, y) {g.(x)}) * callable * self
      end

      def >(callable)
        self.class.new(->(g, o, x, y) {g.(y)}) * callable * self
      end
    end
  end
end
