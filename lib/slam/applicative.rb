require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    def **(callable)
      str = make_evaluable_string(callable)
      self.class.new(str, [self]) * self
    end

    def <<(callable)
      self.class.new("args.pop; #{@necromancy}") * callable
    end

    def >>(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.pop; #{str}", [self]) * self
    end
  end
end
