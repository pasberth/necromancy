module Slam

  class Dunk < BasicObject

    protected *instance_methods
    protected

    def initialize(necromancy = "args", avoid_gc = [])
      @necromancy = necromancy
      @avoid_gc = avoid_gc
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

      necromancy = "[#{getproc}.(*(#@necromancy)#{getargs}#{getblock})]"
      self.class.new(necromancy, [self])
    end

    def to_proc
      instance_eval("->(*args) { ->(*xs){xs.size==1 ? xs.first : xs}.(*(#@necromancy)) }")
    end

    def class
      @class ||= (class << self; self end).superclass
    end

    def make_evaluable_literal(anyref)
      case anyref
      when nil, ::Integer, ::Float, ::Symbol
        anyref.inspect
      else
        @avoid_gc << anyref
        "::ObjectSpace._id2ref(#{anyref.__id__})"
      end
    end

    def make_evaluable_string(anyref)
      case anyref
      when Dunk
        anyref.instance_eval {@necromancy}
      when ::Symbol
        "[:#{anyref}.to_proc.(*args)]"
      else
        prc = anyref.to_proc
        @avoid_gc << prc
        "[::ObjectSpace._id2ref(#{prc.__id__}).(*args)]"
      end
    end
  end
end
