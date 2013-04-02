module Slam

  module Ext

    if RUBY_VERSION < "2.0.0"

      def using(mod)
        include(mod)
      end

      def refine(_, &block)
        module_eval(&block)
      end

    else

      def using(mod)
        # ..
      end
    end

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
