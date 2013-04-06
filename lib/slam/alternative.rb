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
      empty_mth = ->(*args) { empty?(*args) }
      @avoid_gc << empty_mth
      str = make_evaluable_string(callable)
      necromancy = "ObjectSpace._id2ref(#{empty_mth.__id__}).(*((#{str}).tap{|xs| stack << xs})) ? stack.pop : (xs = stack.pop + xs; #@necromancy)"
      self.class.new(necromancy)
    end

    def |(callable)
      empty_mth = ->(*args) { empty?(*args) }
      @avoid_gc << empty_mth
      str = make_evaluable_string(callable)
      necromancy = "ObjectSpace._id2ref(#{empty_mth.__id__}).(*((#@necromancy).tap{|xs|stack << xs})) ? (stack.pop; #{str}) : stack.pop"
      self.class.new(necromancy)
    end
  end
end
