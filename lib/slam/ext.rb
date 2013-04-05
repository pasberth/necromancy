module Slam

  module Ext

    def branch(&block)
      mod = self
      Module.new { include mod; extend Ext; module_eval(&block) }
    end

    def call(*names)
      branch { protected *instance_methods; public *names }
    end

    def hiding(*names)
      branch { protected *names }
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
