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
  end
end
