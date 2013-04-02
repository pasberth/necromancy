require 'slam'

L = Slam::Alternative::Dunk.new
puts (1..100).map &(L%15).zero? ** proc{proc{"FizzBuzz"}} |
                   (L%3).zero?  ** proc{proc{"Fizz"}}     |
                   (L%5).zero?  ** proc{proc{"Buzz"}}     |
                   L
