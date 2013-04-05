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
end