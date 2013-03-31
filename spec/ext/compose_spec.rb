require 'slam'
require 'slam/ext/compose'

describe Slam::Dunk do

  let(:l) { described_class.new }

  example do

    %w(0 1 2).map(&l.to_i >> "foo".method(:[])).
      should == %w(f o o)
  end
end
