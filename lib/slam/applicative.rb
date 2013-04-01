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
        self.class.new(->(o, x, y) {x}) * callable * self
      end

      def >(callable)
        self.class.new(->(o, x, y) {y}) * callable * self
      end
    end
  end
end
