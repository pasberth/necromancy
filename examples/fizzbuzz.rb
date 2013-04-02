require 'slam'

if RUBY_VERSION < "2.0.0"
  class Slam::Dunk; include ::Slam::Alternative; end
else
  using Slam::Alternative
end

L = Slam::Dunk.new
puts (1..100).map &(L%15).zero? ** proc{proc{"FizzBuzz"}} |
                   (L%3).zero?  ** proc{proc{"Fizz"}}     |
                   (L%5).zero?  ** proc{proc{"Buzz"}}     |
                   L
