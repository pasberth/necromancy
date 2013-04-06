require 'necromancy'

describe Necromancy::Alternative do

  let(:l) { described_class.new }

  example do
    [{ x: 42}, {}].map(&l[:x] | proc{0}).
      should == [{ x: 42}, {}].map {|h| h[:x] || 0 }
  end

  example do
    i = 1
    (1..5).map(&l.+ * proc{1}).
      should == (1..5).map {|x| x + i if i }
  end

  example do
    i = nil
    (1..5).map(&l.+ * proc{}).
      should == (1..5).map {|x| x + i if i }
  end

  example do
    (1..5).map(&l.odd? >> l.succ | l.pred).
      should == (1..5).map {|x| x.odd? ? x.succ : x.pred }
  end

  example do
    [{x: 1}, {y: 2}].inject(&l.merge << ->(x,y){x&&y}).
      should == [{x: 1}, {y: 2}].inject {|x, y| x.merge(y) if x && y }
  end

  example do
    [{x: 1}, nil, {y: 2}].inject(&l.merge << ->(x,y){x&&y}).
      should == [{x: 1}, nil, {y: 2}].inject {|x, y| x.merge(y) if x && y }
  end
end
