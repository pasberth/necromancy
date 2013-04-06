module Necromancy

  module Control

    def branch(&block)
      mod = self
      Module.new { include mod; extend Control; module_eval(&block) }
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
      if name == :Necromancy
        Class.new(::Necromancy::Necromancy) { include mod }
      else
        super
      end
    end
  end
end
