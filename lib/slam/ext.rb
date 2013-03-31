require 'slam'

module Slam

  module Ext

    if RUBY_VERSION < "2.0.0"
      def refine(klass, &block)
        klass.class_eval(&block)
      end
    else
      require 'slam/ext/compose'
      require 'slam/ext/or'
    end
  end
end
