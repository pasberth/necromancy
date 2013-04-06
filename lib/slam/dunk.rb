module Slam

  class Dunk < BasicObject

    protected *instance_methods
    protected

    def initialize(necromancy = "args", *args, &block)
      @necromancy = necromancy
      @args = args
      @block = block
      @avoid_gc = []
    end

    def method_missing(name, *args, &block)
      getargs = args.map{|x|"ObjectSpace._id2ref(#{x.__id__}),"}.join
      getblock = "ObjectSpace._id2ref(#{block.__id__})"
      necromancy = "[:#{name}.to_proc.(*(#@necromancy), #{getargs} &(#{getblock}))]"
      self.class.new(necromancy)
    end

    def to_proc
      ::TOPLEVEL_BINDING.eval("->(*args) { ->(*xs){xs.size==1 ? xs.first : xs}.(*(#@necromancy)) }")
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
