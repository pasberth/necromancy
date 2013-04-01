require 'slam'
require 'slam/ext'

module Slam

  module Arrow; extend Ext

    refine Dunk do

      def &(callable)
        f = ->(g, *args, &block) { self.callable.(->(*_){ g.(*_, callable.to_proc.(*args, &block)) }, *args, &block) }
        self.class.new(f)
      end
    end
  end
end
