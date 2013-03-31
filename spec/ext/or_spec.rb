require 'slam'
require 'slam/ext/or'

describe Slam::Dunk do

  let(:l) { described_class.new }

  example do
    [{ x: 42}, {}].map(&l[:x] | proc{0}).
      should == [42, 0]
  end
end
