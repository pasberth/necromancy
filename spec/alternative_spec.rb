require 'necromancy'

describe Necromancy::Alternative do

  let(:l) { described_class.new }
  shared_examples_for "pure" do

    example { proc(&f * l).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&f * l | l).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&f * l | g).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&l | g).(r).should == proc(&l).(r) }
    example { proc(&l | f * l).(r).should == proc(&l).(r) }
    example { proc(&l | l ** f).(r).should == proc(&l).(r) }
    example { proc(&l ** f).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&l ** f | l).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&l ** f | g).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&l >> g).(r).should == proc(&g).(r) }
    example { proc(&l >> f * l).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&g << l).(r).should == proc(&g).(r) }
    example { proc(&f * l << l).(r).should == proc(&f).(r, proc(&l).(r)) }
    pending { proc(&h * l * l).(r).should == proc(&f).(r, proc(&l).(r), proc(&l).(r)) }
  end

  shared_examples_for "empty" do

    example { proc(&f * l).(r).should == proc(&l).(r) }
    example { proc(&f * l | g).(r).should == proc(&g).(r) }
    example { proc(&l | g).(r).should == proc(&g).(r) }
    example { proc(&l | f * l).(r).should == proc(&l).(r) }
    example { proc(&l | l ** f).(r).should == proc(&l).(r) }
    example { proc(&l ** f).(r).should == proc(&l).(r) }
    example { proc(&l ** f | l).(r).should == proc(&l).(r) }
    example { proc(&l ** f | g).(r).should == proc(&g).(r) }
    example { proc(&l >> g).(r).should == proc(&l).(r) }
    example { proc(&l >> f * l).(r).should == proc(&l).(r) }
    example { proc(&g << l).(r).should == proc(&l).(r) }
    example { proc(&f * l << l).(r).should == proc(&l).(r) }
  end

  it_behaves_like "empty" do
    let(:r) { nil }
    let(:f) { described_class.new.inspect }
    let(:g) { described_class.new.inspect }
  end

  it_behaves_like "empty" do
    let(:r) { false }
    let(:f) { described_class.new.& }
    let(:g) { !described_class.new }
  end

  it_behaves_like "pure" do
    let(:r) { true }
    let(:f) { described_class.new.& }
    let(:g) { !described_class.new }
  end

  it_behaves_like "pure" do
    let(:r) { 0 }
    let(:f) { described_class.new.^ }
    let(:g) { !described_class.new }
  end

  it_behaves_like "pure" do
    let(:r) { [] }
    let(:f) { described_class.new.+ }
    let(:g) { described_class.new.first }
  end

  it_behaves_like "pure" do
    let(:r) { {} }
    let(:f) { described_class.new.merge }
    let(:g) { described_class.new[:x] }
  end

  it_behaves_like "empty" do
    let(:r) { {} }
    let(:l) { described_class.new[:x] }
    let(:f) { described_class.new.== }
    let(:g) { described_class.new.inspect }
  end

  it_behaves_like "pure" do
    let(:r) { {x: 42} }
    let(:l) { described_class.new[:x] }
    let(:f) { described_class.new.!= }
    let(:g) { described_class.new.inspect }
  end
end
