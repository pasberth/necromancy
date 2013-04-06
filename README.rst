Necromancy
================================================================================

Necromancy conjures up the functional code.

.. code:: ruby

  require 'necromancy'
  N = Necromancy.new

  # [:foo, :bar, :baz].map{|s| s.to_s }.map{|s| s.upcase }
  [:foo, :bar, :baz].map &N.to_s . upcase

  # [:foo, :hoge, :bar, :fuga].select{|s| s.to_s.length > 3} # => [:hoge, :fuga]
  [:foo, :hoge, :bar, :fuga].select &N.to_s . length > 3

Features
--------------------------------------------------------------------------------

Function composition
________________________________________________________________________________

Every messages to instance of `Necromancy` are function composition
by default. that is left-to-right composition.

.. code:: ruby

  N.f.g == ->(o) { :g.to_proc(:f.to_proc(o)) } == ->(o) { o.f.g }


Application with arguments
________________________________________________________________________________

If a message was called with some argument given,
their arguments are given into that function each time.

.. code:: ruby

  N.f(x) == ->(o) { :f.to_proc(o, x) } == ->(o) { o.f(x) }


Rich extensions.
________________________________________________________________________________
If you want, you can use extensions by clojuring up the evil spirit.

.. code:: ruby

  M = Necromancy.Alternative.new
  M.x | M.y == ->(o) { o.x || o.y }

Examples
--------------------------------------------------------------------------------

Simple Function composion
________________________________________________________________________________

First, your create a `Necromancy` object.
it is immutable, you can save it to any variable you like.
for example, that is constant, global varibale, instance variable, class variable, local variable, etc.

.. code:: ruby

  N = Necromancy.new

After, you send some message to N when you need to write a simple block.

.. code:: ruby

  (1..5).map &N ** 2 # => [1, 4, 9, 16, 25]

Function composion
________________________________________________________________________________

.. code:: ruby

  N = Necromancy.Category.new
  ary = ('A'..'Z').to_a
  (0..4).map &N > ary.method(:[]) # => ["A", "B", "C", "D", "E"]

Multiple accessing to attribtues
________________________________________________________________________________

.. code:: ruby

  N = Necromancy.Arrow.new
  str = "foo"
  lambda(&N.upcase & :capitalize & :reverse).(str) # => ["FOO", "Foo", "oof"]


Maybe evaluating
________________________________________________________________________________

.. code:: ruby

  N = Necromancy.Alternative.new
  str_or_nil = ["foo", nil].sample
  str_or_nil.tap &N >> N.upcase! # => nil or "FOO"

Alias importation
________________________________________________________________________________

.. code:: ruby

  N = Necromancy.Alternative.using(:>> => :then).new
  str_or_nil = ["foo", nil].sample
  str_or_nil.tap &(N.then N.upcase!) # => nil or "FOO"

Hiding importation
________________________________________________________________________________

.. code:: ruby

  N = Necromancy.Alternative.hiding(:*, :**).new
  (1..5).map &N ** 2 # => [1, 4, 9, 16, 25]

Specifying importation
________________________________________________________________________________

.. code:: ruby

  N = Necromancy.Alternative.(:>>).new
  str_or_nil = ["foo", nil].sample
  str_or_nil.tap &N >> N.upcase! # => nil or "FOO"
  (1..5).map &N ** 2 # => [1, 4, 9, 16, 25]

Multiple module importation
________________________________________________________________________________

.. code:: ruby

  N = Necromancy.Arrow.Alternative.hiding(:*, :**).new
  [nil, 42, "foo"].map &N.is_a?(Integer) >> (N * 2 & N ** 2) | N # => [nil, [84, 1764], "foo"]


Installation
--------------------------------------------------------------------------------

.. code:: sh

  gem install necromancy
