require 'necromancy'

describe Necromancy::Applicative::Necromancy do

  let(:l) { described_class.new }

  example do

    %w(foo bar baz).map(&l.+ * :reverse).
      should == %w(foo bar baz).map {|s| s + s.reverse }
  end

  example do

    %w(foo bar baz).map(&l.reverse ** :+).
      should == %w(foo bar baz).map {|s| s + s.reverse }
  end
end
