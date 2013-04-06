module Slam

  class Dunk < BasicObject

    protected *instance_methods
    protected

    def initialize(necromancy = "args", *args, &block)
      $stdout.puts([necromancy, args].inspect)
      @necromancy = necromancy
      @args = args
      @block = block
    end

    def method_missing(name, *args, &block)
      getargs = args.map{|x|"ObjectSpace._id2ref(#{x.__id__}),"}.join
      getblock = "ObjectSpace._id2ref(#{block.__id__})"
      necromancy = "[:#{name}.to_proc.(*(#@necromancy), #{getargs} &(#{getblock}))]"
      self.class.new(necromancy)
    end

    def to_proc
      ::TOPLEVEL_BINDING.eval("->(*args) { ->(*xs){xs.size==1 ? xs.first : xs}.(*(#@necromancy))  }")
    end

    def class
      @class ||= (class << self; self end).superclass
    end
  end
end
