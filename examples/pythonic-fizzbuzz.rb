require 'necromancy'

N = Necromancy.Alternative[:<< => :if,
                           :>> => :then,
                           :|  => :else].new
puts (1..100).map &( (N%15).zero? .then(proc{"FizzBuzz"}) .else   \
                     (N%3).zero?  .then(proc{"Fizz"})     .else   \
                     (N%5).zero?  .then(proc{"Buzz"})     .else N )
