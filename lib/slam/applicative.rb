require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    def **(callable)
      str = make_evaluable_string(callable)
      self.class.new(str) * self
    end

    def <<(callable)
      self.class.new("xs.shift; #@necromancy") * callable
    end

    def >>(callable)
      str = make_evaluable_string(callable)
      self.class.new("xs.shift; #{str}") * self
    end
  end
end
