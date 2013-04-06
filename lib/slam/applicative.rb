require 'slam'
require 'slam/ext'

module Slam

  module Applicative; extend Ext

    def **(callable)
      str = make_evaluable_string(callable)
      self.class.new(str, @references) * self
    end

    def <<(callable)
      self.class.new("args.pop; #{@necromancy}", @references) * callable
    end

    def >>(callable)
      str = make_evaluable_string(callable)
      self.class.new("args.pop; #{str}", @references) * self
    end
  end
end
