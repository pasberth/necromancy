module Slam

  module Ext

    def branch(&block)
      mod = self
      Module.new { include mod; extend Ext; module_eval(&block) }
    end

    def call(*targets)
      branch { protected *instance_methods }.using(*targets)
    end

    def using(*targets)
      names = targets.select { |t| t.is_a? Symbol }
      aliases = targets.select { |t| t.is_a? Hash }.inject(:merge)
      branch do
        public *names
        aliases.each do |org, als|
          alias_method(als, org)
          protected org
          public als
        end
      end
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
