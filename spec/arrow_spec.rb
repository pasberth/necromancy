require 'slam'

class ArrowDunk < Slam::Dunk
  include ::Slam::Arrow
end

describe ArrowDunk do

  let(:l) { described_class.new }

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize).
      should == [ ["FOO", "Foo"],
                  ["BAR", "Bar"],
                  ["BAZ", "Baz"] ]
  end
end
