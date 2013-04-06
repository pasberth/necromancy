module Slam

  class Dunk < BasicObject

    protected *instance_methods
    protected

    def initialize(necromancy = "args", avoid_gc = [])
      @necromancy = necromancy
      @avoid_gc = avoid_gc
    end

    def method_missing(name, *args, &block)
      avoid_gc = [self]
      getproc = ":#{name}.to_proc"

      if args.none?
        getargs = nil
      else
        getargs = ", *(::ObjectSpace._id2ref(#{args.__id__}))"
        avoid_gc << args
      end

      if block
        getblock = ", &(::ObjectSpace._id2ref(#{block.__id__}))"
        avoid_gc << block
      else
        getblock = nil
      end

      necromancy = "[#{getproc}.(*(#@necromancy)#{getargs}#{getblock})]"
      self.class.new(necromancy, avoid_gc)
    end

    def to_proc
      instance_eval("->(*args) { ->(*xs){xs.size==1 ? xs.first : xs}.(*(#@necromancy)) }")
    end

    def class
      @class ||= (class << self; self end).superclass
    end

    def make_evaluable_string(anyref)
      case anyref
      when Dunk
        anyref.instance_eval {@necromancy}
      else
        prc = anyref.to_proc
        @avoid_gc << prc
        "[::ObjectSpace._id2ref(#{prc.__id__}).(*args)]"
      end
    end
  end
end
