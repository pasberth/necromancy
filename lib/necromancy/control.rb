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
      warn <<EOF
Necromancy.Hoge.() deprecated.
Use Necromancy.Hoge().
EOF
      branch { protected *instance_methods }[*targets]
    end

    def using(*targets)
      warn <<EOF
Necromancy.Hoge.using() deprecated.
Use Necromancy.Hoge[].
EOF
      self[*targets]
    end

    def [](*targets)
      names = targets.select { |t| t.is_a? Symbol }
      aliases = targets.select { |t| t.is_a? Hash }.inject(:merge) || {}
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

    def self.extended(mod)
      return unless mod.name and mod.name.start_with? self.name
      mthname = mod.name.sub("#{self.name}::", '')
      define_method mthname do |*args, &block|
        if args.empty?
          branch { include mod }
        else
          branch { include mod; protected *mod.instance_methods }[*args, &block]
        end
      end
    end
  end
end
