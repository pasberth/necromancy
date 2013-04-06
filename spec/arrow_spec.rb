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
    example { proc(&l & l > f).(r).should == proc(&f).(proc(&l).(r), proc(&l).(r)) }
    example { proc(&l & l > ga * gb).(r).should == [proc(&ga).(proc(&l).(r)), proc(&gb).(proc(&l).(r))] }
    example { proc(&l & l & l > ga * gb * ga).(r).should == [proc(&ga).(proc(&l).(r)), proc(&gb).(proc(&l).(r)), proc(&ga).(proc(&l).(r))] }
    example { proc(&l & l & l & l > ga * gb * ga * gb).(r).should == [proc(&ga).(proc(&l).(r)), proc(&gb).(proc(&l).(r)), proc(&ga).(proc(&l).(r)), proc(&gb).(proc(&l).(r))] }
  end

  it_behaves_like "an Arrow" do
    let(:r) { 0 }
    let(:f) { :+ }
    let(:ga) { +l }
    let(:gb) { -l }
  end

  it_behaves_like "an Arrow" do
    let(:r) { [] }
    let(:f) { :+ }
    let(:ga) { l.first }
    let(:gb) { l.last }
  end

  it_behaves_like "an Arrow" do
    let(:l) { described_class.new.keys }
    let(:r) { { x: 42 } }
    let(:f) { :+ }
    let(:ga) { described_class.new.first }
    let(:gb) { described_class.new.last }
  end
end
