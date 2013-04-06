module Necromancy

  module Control

    def new
      mod = self
      Class.new(::Necromancy::Necromancy) { include mod }.new
    end

    def branch(&block)
      mod = self
      Module.new { include mod; extend Control; module_eval(&block) }
    end

    private :branch

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

    def method_missing(name, *args, &block)
      super if name[0].upcase != name[0]
      if ::Necromancy::Control.const_defined? name
        branch { include ::Necromancy::Control.const_get(name) }
      else
        super
      end
    end
  end
end