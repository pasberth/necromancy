require 'necromancy'

L = Necromancy::Alternative.hiding(:*, :**)::Necromancy.new

ary = [1, nil, 2, nil, 3]
p ary.map &(L | proc{0}) * 10 # => [10, 0, 20, 0, 3]
