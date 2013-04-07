module Necromancy

  class Necromancy < BasicObject

    protected *instance_methods
    protected

    def initialize(necromancy = "args", references = [])
      @necromancy = necromancy
      @references = references
    end

    def method_missing(name, *args, &block)
      getproc = ":#{name}.to_proc"

      if args.size == 0
        getargs = nil
      elsif args.size == 1
        getargs = ", (#{make_evaluable_literal(args[0])})"
      else
        getargs = ", *(#{make_evaluable_literal(args)})"
      end

      if block
        getblock = ", &(#{make_evaluable_literal(block)})"
      else
        getblock = nil
      end

      necromancy = "[#{getproc}.(*(#{@necromancy})#{getargs}#{getblock})]"
      self.class.new(necromancy, @references.dup)
    end

    def to_proc
      mkvariables = @references.size.times.map {|i| "@_#{i} = self.get_ref(#{i})" }.join(';')
      instance_eval(<<-NECROMANCY)
        #{mkvariables};
        ->(*args) { stack = []; xs = (#{@necromancy}); xs.size == 1 ? xs.first : xs }
      NECROMANCY
    end

    def class
      @class ||= (class << self; self end).superclass
    end

    def get_ref(i)
      @references[i]
    end

    def set_ref(i, v)
      @references[i] = v
    end

    def add_val(v)
      i = @references.size
      @references[i] = v
      i
    end

    def make_evaluable_literal(anyref)
      case anyref
      when nil, ::Integer, ::Float, ::Symbol
        anyref.inspect
      else
        i = add_val(anyref)
        "@_#{i}"
      end
    end

    def make_evaluable_string(anyref)
      case anyref
      when Necromancy
        references = anyref.instance_eval {@references}
        necromancy = anyref.instance_eval {@necromancy}.dup
        references.size.times do |i|
          necromancy.gsub!("@_#{i}", "@_#{i + references.size}")
        end
        @references.concat(references)
        necromancy
      when ::Symbol
        "[:#{anyref}.to_proc.(*args)]"
      else
        prc = anyref.to_proc
        i = add_val(prc)
          "[@_#{i}.(*args)]"
      end
    end
  end
end
