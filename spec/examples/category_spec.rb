require 'necromancy'

describe Necromancy::Control::Category do

  let(:l) { described_class.new }

  example do

    %w(0 1 2).map(&l.to_i > "foo".method(:[])).
      should == %w(0 1 2).map {|x| "foo"[x.to_i] }
  end

  example do
    lambda(&l.to_i > l * 2).('42').
      should == '42'.to_i * 2
  end

  example do
    lambda(&l.to_i < l * 2).('42').
      should == ('42' * 2).to_i
  end
end
