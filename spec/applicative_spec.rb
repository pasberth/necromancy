require 'slam'

class ApplicativeDunk < Slam::Dunk
  include ::Slam::Applicative
end

describe ApplicativeDunk do

  let(:l) { described_class.new }

  example do
    (1..5).map(&l.+ * proc{1}).
      should == (2..6).to_a
  end

  example do
    (1..5).map(&l.+ * proc{}).
      should == [nil]*5
  end
end
