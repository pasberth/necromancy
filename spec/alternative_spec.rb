require 'slam'

class AlternativeDunk < Slam::Dunk
  include ::Slam::Alternative
end

describe AlternativeDunk do

  let(:l) { described_class.new }

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
