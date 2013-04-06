require 'necromancy'

class TestStr < String

  def f
    TestStr.new upcase
  end

  def g(x)
    TestStr.new self + x
  end
end

describe Necromancy::Dunk do

  let(:l) { described_class.new }

  shared_examples_for "a Dunk" do

    example { proc(&l.f).(r).should == r.f  }
    example { proc(&l.g(x)).(r).should == r.g(x)  }
    example { proc(&l.f . g(x)).(r).should == r.f.g(x)  }
    example { proc(&l.g(x) . f).(r).should == r.g(x).f  }
    example { proc(&l.f . f).(r).should == r.f.f  }
    example { proc(&l.g(x) . g(x)).(r).should == r.g(x).g(x)  }
  end

  it_behaves_like "a Dunk" do

    let(:r) { TestStr.new 'hoge' }
    let(:x) { 'fuga' }
  end
end
