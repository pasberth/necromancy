require 'necromancy'

N = Necromancy.Alternative.hiding(:*, :**).new

ary = [1, nil, 2, nil, 3]
p ary.map &(N | proc{0}) * 10 # => [10, 0, 20, 0, 3]
