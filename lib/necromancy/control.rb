module Necromancy

  module Control

    # Creates a {Necromancy::Necromancy} object including the {Necromancy::Control}.
    # @return [Necromancy]
    def new
      mod = self
      Class.new(::Necromancy::Necromancy) { include mod }.new
    end

    def branch(&block)
      mod = self
      Module.new { include mod; extend Control; module_eval(&block) }
    end

    private :branch

    # @deprecated
    def call(*targets)
      warn <<EOF
Necromancy.Hoge.() deprecated.
Use Necromancy.Hoge().
EOF
      branch { protected *instance_methods }[*targets]
    end

    # @deprecated
    def using(*targets)
      warn <<EOF
Necromancy.Hoge.using() deprecated.
Use Necromancy.Hoge[].
EOF
      self[*targets]
    end

    # Reveals some methods and Creates some aliases.
    # @param [Symbol] target Reveals a method of the symbol.
    # @param [Hash]   target Hides all methods of each key and creates aliases from each value to each key.
    # @param [Array]  targets A list of Symbol or Hash that will be processing as target.
    # @return [Control] Processed new {Necromancy::Control} object.
    def [](target, *targets)
      targets.unshift(target)
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

    # Hides some methods.
    # @param [Symbol] name Hides a method of the name.
    # @param [Array]  names A list of a Symbol that will be processing as name.
    # @return [Control] Processed new {Necromancy::Control} object.
    def hiding(name, *names)
      names.unshift(name)
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
