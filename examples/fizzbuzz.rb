require 'necromancy'

L = Necromancy::Alternative::Necromancy.new
puts (1..100).map &(L%15).zero? >> proc{"FizzBuzz"} |
                   (L%3).zero?  >> proc{"Fizz"}     |
                   (L%5).zero?  >> proc{"Buzz"}     |
                   L
