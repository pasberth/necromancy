require 'slam'
require 'slam/ext'

module Slam

  module Category; extend Ext

    refine Dunk do

      def >>(callable)
        f = ->(g, *args, &block) { g.(@callable.(callable.to_proc, *args, &block)) }
        self.class.new(f)
      end

      def <<(callable)
        f = ->(g, *args, &block) { g.(to_proc.(callable.to_proc.(*args, &block))) }
        self.class.new(f)
      end
    end
  end
end
