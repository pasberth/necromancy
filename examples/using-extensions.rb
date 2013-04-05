require 'slam'

L = Slam::Category::Dunk.new
p %w(foo bar baz).map &L > "foobarbaz".method(:index) # => [0, 3, 6]
