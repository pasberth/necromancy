require 'slam'

class OrDunk < Slam::Dunk
  include ::Slam::Alternative
end

describe OrDunk do

  let(:l) { described_class.new }

  example do
    [{ x: 42}, {}].map(&l[:x] | proc{0}).
      should == [42, 0]
  end
end
