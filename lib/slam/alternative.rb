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
      unless defined? @empty_mth
        @empty_mth = ->(*args) { empty?(*args) }
        @avoid_gc << @empty_mth
      end
      str = make_evaluable_string(callable)
      necromancy = "ObjectSpace._id2ref(#{@empty_mth.__id__}).(*(_xs = (#{str}))) ? _xs : (xs = _xs + xs; #@necromancy)"
      self.class.new(necromancy)
    end

    def |(callable)
      unless defined? @empty_mth
        @empty_mth = ->(*args) { empty?(*args) }
        @avoid_gc << @empty_mth
      end
      @avoid_gc << empty_mth
      str = make_evaluable_string(callable)
      necromancy = "ObjectSpace._id2ref(#{@empty_mth.__id__}).(*(_xs = #@necromancy)) ? (#{str}) : _xs"
      self.class.new(necromancy)
    end
  end
end
