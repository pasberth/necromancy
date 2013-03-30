Slam: Symbol-LAMbda
================================================================================

Slam provides an symbol-hack.

.. code:: ruby

  L = Slam::Dunk.new

  # [:foo, :bar, :baz].map{|s| s.to_s }.map{|s| s.upcase }
  # [:foo, :bar, :baz].map(&:to_s).map(&:upcase)

  [:foo, :bar, :baz].map(&L.to_s . upcase)

  # [:foo, :hoge, :bar, :fuga].select{|s| s.to_s.length > 3} # => [:hoge, :fuga]

  [:foo, :hoge, :bar, :fuga].select(&L.to_s . length > 3)

Installation
--------------------------------------------------------------------------------

.. code:: sh

  gem install slam
