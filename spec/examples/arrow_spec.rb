require 'necromancy'

describe Necromancy::Control::Arrow do

  let(:l) { described_class.new }

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize).
      should == %w(foo bar baz).map {|s| [s.upcase, s.capitalize] }
  end

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize & :reverse).
      should == %w(foo bar baz).map {|s| [s.upcase, s.capitalize, s.reverse] }
  end

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize > :+).
      should == %w(foo bar baz).map {|s| s.upcase + s.capitalize }
  end

  example do
    %w(foo bar baz).map(&l.upcase & :capitalize > l.chars.to_a * :to_sym).
      should == %w(foo bar baz).map {|s| [s.upcase.chars.to_a, s.capitalize.to_sym] }
  end
end
