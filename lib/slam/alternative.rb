require 'slam'
require 'slam/ext'

module Slam

  module Alternative; extend Ext

    include Slam::Applicative

    def empty?(alternative)
      not alternative
    end

    protected :empty?

    def *(callable) 
      str = make_evaluable_string(callable)
      necromancy = "self.empty?(*(xs = (#{str}))) ? xs : (args.concat(xs); #{@necromancy})"
      self.class.new(necromancy, @references)
    end

    def |(callable)
      str = make_evaluable_string(callable)
      necromancy = "self.empty?(*(xs = (#{@necromancy}))) ? (#{str}) : xs"
      self.class.new(necromancy, @references)
    end
  end
end
