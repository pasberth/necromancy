require 'slam'

class ArrowDunk < Slam::Dunk
  include ::Slam::Arrow
end

describe ArrowDunk do

  let(:l) { described_class.new }

  shared_examples_for "an Arrow" do
    example { proc(&l & l).(r).should == [proc(&l).(r), proc(&l).(r)] }
    example { proc(&l & l & l).(r).should == [proc(&l).(r), proc(&l).(r), proc(&l).(r)] }
    example { proc(&l & l & l & l).(r).should == [proc(&l).(r), proc(&l).(r), proc(&l).(r), proc(&l).(r)] }
  end

  it_behaves_like "an Arrow" do
    let(:r) { 0 }
  end

  it_behaves_like "an Arrow" do
    let(:r) { [] }
  end

  it_behaves_like "an Arrow" do
    let(:l) { described_class.new.keys }
    let(:r) { { x: 42 } }
  end
end
