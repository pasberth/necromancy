require 'slam'

class AlternativeDunk < Slam::Dunk
  include ::Slam::Alternative
end

describe AlternativeDunk do

  let(:l) { described_class.new }

  describe "#|" do
    subject { proc(&l | proc{x}) }
    let(:x) { 42 }
    example { subject.(nil).should == x }
    example { subject.(false).should == x }
    example { subject.(true).should be_true }
  end

  describe "#*" do
    subject { proc(&l.+ * proc{x}) }

    context do
      let(:x) { 42 }
      example { subject.call(1).should == x + 1 }
    end

    context do
      let(:x) { nil }
      example { subject.call(1).should == x }
    end

    context do
      let(:x) { false }
      example { subject.call(1).should == x }
    end
  end

  example do
    [{ x: 42}, {}].map(&l[:x] | proc{0}).
      should == [42, 0]
  end

  example do
    (1..5).map(&l.+ * proc{1}).
      should == (2..6).to_a
  end

  example do
    (1..5).map(&l.+ * proc{}).
      should == [nil]*5
  end

  example do
    (1..5).map(&(l.odd? > l.succ) | l.pred).
      should == [2, 1, 4, 3, 6]
  end
end
