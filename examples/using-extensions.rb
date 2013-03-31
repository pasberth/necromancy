require 'slam'

if RUBY_VERSION < "2.0.0"
  require 'slam/ext/compose'
else
  require 'slam/ext'
  using Slam::Ext::Compose
end

L = Slam::Dunk.new
p %w(foo bar baz).map &L >> "foobarbaz".method(:index) # => [0, 3, 6]
