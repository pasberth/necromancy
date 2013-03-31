module Slam

  module Ext

    if RUBY_VERSION < "2.0.0"
      def refine(_, &block)
        module_eval(&block)
      end
    end
  end
end
