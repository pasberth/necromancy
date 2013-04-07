# @example
#   require 'necromancy'
#   N = Necromancy.Alternative(:>>, :|).new
#   puts (1..100).map &(N%15).zero? >> proc{"FizzBuzz"} |
#                      (N%3).zero?  >> proc{"Fizz"}     |
#                      (N%5).zero?  >> proc{"Buzz"}     |
#                      N
module Necromancy

  require 'necromancy/version'
  require 'necromancy/necromancy'
  require 'necromancy/control'
  require 'necromancy/control/category'
  require 'necromancy/control/arrow'
  require 'necromancy/control/applicative'
  require 'necromancy/control/alternative'

  extend Control
end
