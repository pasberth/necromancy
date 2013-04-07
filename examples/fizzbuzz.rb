require 'necromancy'

N = Necromancy.Alternative.new
puts (1..100).map &(N%15).zero? >> proc{"FizzBuzz"} |
                   (N%3).zero?  >> proc{"Fizz"}     |
                   (N%5).zero?  >> proc{"Buzz"}     |
                   N
