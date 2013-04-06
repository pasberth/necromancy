Necromancy
================================================================================

Necromancy conjures up the functional code.

.. code:: ruby

  require 'necromancy'
  N = Necromancy.new

  # [:foo, :bar, :baz].map{|s| s.to_s }.map{|s| s.upcase }
  # [:foo, :bar, :baz].map(&:to_s).map(&:upcase)

  [:foo, :bar, :baz].map &N.to_s . upcase

  # [:foo, :hoge, :bar, :fuga].select{|s| s.to_s.length > 3} # => [:hoge, :fuga]

  [:foo, :hoge, :bar, :fuga].select &N.to_s . length > 3

  # (1..5).map { |x| x ** 2 }

  (1..5).map &N ** 2 # => [1, 4, 9, 16, 25]

Installation
--------------------------------------------------------------------------------

.. code:: sh

  gem install necromancy
