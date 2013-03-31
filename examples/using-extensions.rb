require 'slam'

if RUBY_VERSION < "2.0.0"
  class Slam::Dunk; include ::Slam::Category; end
else
  using Slam::Category
end

L = Slam::Dunk.new
p %w(foo bar baz).map &L >> "foobarbaz".method(:index) # => [0, 3, 6]
