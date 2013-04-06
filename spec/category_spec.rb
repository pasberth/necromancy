require 'necromancy'

class CategoryNecromancy < Necromancy::Necromancy
  include ::Necromancy::Category
end

describe CategoryNecromancy do

  let(:l) { described_class.new }

  shared_examples_for 'a Category' do

    example { proc(&l > f).(r).should == proc(&f).(proc(&l).(r)) }
    example { proc(&f < l).(r).should == proc(&f).(proc(&l).(r)) }
    example { proc(&l > f > g).(r).should == proc(&g).(proc(&f).(proc(&l).(r))) }
    example { proc(&g < f < l).(r).should == proc(&g).(proc(&f).(proc(&l).(r))) }
  end

  it_behaves_like "a Category" do

    let(:r) { '42' }
    let(:f) { described_class.new.to_i }
    let(:g) { described_class.new + 1 }
  end
end
