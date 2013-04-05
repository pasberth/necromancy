require 'slam'
require 'slam/ext'

module Slam

  module Category; extend Ext

    def >(callable)
      f = ->(g, *xs, &block) { ->(*ys) { g.(@callable.(callable.to_proc, *xs, *ys, &block).()) } }
      self.class.new(f)
    end

    def <(callable)
      f = ->(g, *xs, &block) { ->(*ys) { g.(to_proc.(callable.to_proc.(*xs, *ys, &block))) } }
      self.class.new(f)
    end
  end
end
