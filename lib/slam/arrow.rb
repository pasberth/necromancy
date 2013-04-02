require 'slam'
require 'slam/ext'

module Slam

  module Arrow; extend Ext

    refine Dunk do

      def &(callable)
        f = ->(g, *xs, &block) { ->(*ys) { @callable.(->(*r){ g.(*r, callable.to_proc.(*xs, *ys, &block)) }, *xs, *ys, &block).() } }
        self.class.new(f)
      end
    end
  end
end
