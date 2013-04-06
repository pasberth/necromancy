require 'necromancy'

describe Necromancy::Applicative do

  let(:l) { described_class.new }

  shared_examples_for "an Applicative" do

    example { proc(&f * l).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&l ** f).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&l >> g).(r).should == proc(&g).(r) }
    example { proc(&l >> f * l).(r).should == proc(&f).(r, proc(&l).(r)) }
    example { proc(&g << l).(r).should == proc(&g).(r) }
    example { proc(&f * l << l).(r).should == proc(&f).(r, proc(&l).(r)) }
    pending { proc(&h * l * l).(r).should == proc(&f).(r, proc(&l).(r), proc(&l).(r)) }
  end

  it_behaves_like "an Applicative" do
    let(:r) { nil }
    let(:f) { described_class.new.& }
    let(:g) { !described_class.new }
  end


  it_behaves_like "an Applicative" do
    let(:r) { false }
    let(:f) { described_class.new.& }
    let(:g) { !described_class.new }
  end

  it_behaves_like "an Applicative" do
    let(:r) { true }
    let(:f) { described_class.new.& }
    let(:g) { !described_class.new }
  end

  it_behaves_like "an Applicative" do
    let(:r) { 0 }
    let(:f) { described_class.new.^ }
    let(:g) { !described_class.new }
  end

  it_behaves_like "an Applicative" do
    let(:r) { [] }
    let(:f) { described_class.new.+ }
    let(:g) { described_class.new.first }
  end
end
