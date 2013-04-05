module Slam

  module Ext

    def const_missing(name)
      mod = self
      if name == :Dunk
        Class.new(::Slam::Dunk) { include mod }
      else
        super
      end
    end
  end
end
