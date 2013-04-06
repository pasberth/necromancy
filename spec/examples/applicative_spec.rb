require 'slam'

describe Slam::Applicative::Dunk do

  let(:l) { described_class.new }

  example do

    %w(foo bar baz).map(&l.+ * :reverse).
      should == [ "foooof", "barrab", "bazzab" ]
  end

  example do

    %w(foo bar baz).map(&l.reverse ** :+).
      should == [ "foooof", "barrab", "bazzab" ]
  end
end
