require 'slam'

if RUBY_VERSION < "2.0.0"
  class Slam::Dunk
    include ::Slam::Category
    include ::Slam::Alternative
  end
else
  using Slam::Category
  using Slam::Alternative
end

L = Slam::Dunk.new
f = lambda{|x| x % 2 == 0 ? nil : x * 2}
p (1..5).map(&L >> f | L) # => [2, 2, 6, 4, 10]
