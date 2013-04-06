require 'slam'

describe Slam::Arrow::Dunk do

  let(:l) { described_class.new }

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize).
      should == [ ["FOO", "Foo"],
                  ["BAR", "Bar"],
                  ["BAZ", "Baz"] ]
  end

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize & :reverse).
      should == [ ["FOO", "Foo", "oof"],
                  ["BAR", "Bar", "rab"],
                  ["BAZ", "Baz", "zab"] ]
  end

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize > :+).
      should == [ "FOOFoo", "BARBar", "BAZBaz" ]
  end

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize > l.chars.to_a * :to_sym).
      should == [ [%w(F O O), :Foo],
                  [%w(B A R), :Bar],
                  [%w(B A Z), :Baz] ]
  end
end
