require 'slam'

L = Slam::Alternative.using(:<< => :if,
                            :>> => :then,
                            :|  => :else)::Dunk.new
puts (1..100).map &( (L%15).zero? .then(proc{"FizzBuzz"}) .else   \
                     (L%3).zero?  .then(proc{"Fizz"})     .else   \
                     (L%5).zero?  .then(proc{"Buzz"})     .else L )
