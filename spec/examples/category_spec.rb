require 'necromancy'

describe Necromancy::Control::Category do

  let(:l) { described_class.new }

  example do

    %w(0 1 2).map(&l.to_i > "foo".method(:[])).
      should == %w(0 1 2).map {|x| "foo"[x.to_i] }
  end
end
