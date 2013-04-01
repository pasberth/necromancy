require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    using Category

    refine Dunk do

      def *(callable)
        self << callable
      end

      def **(callable)
        self >> callable
      end
    end
  end
end
