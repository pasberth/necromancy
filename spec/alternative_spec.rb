require 'slam'

class AlternativeDunk < Slam::Dunk
  include ::Slam::Alternative
end

describe AlternativeDunk do

  let(:l) { described_class.new }

  describe "#|" do

    shared_examples_for "hoge" do # TODO: hoge->???
      subject { proc(&l | f) }
      example { subject .(nil)   .should == f.() }
      example { subject .(false) .should == f.() }
      example { subject .(true)  .should == true }
      example { subject .(0)     .should == 0    }
      example { subject .([])    .should == []   }
      example { subject .({})    .should == {}   }
      example { subject .("")    .should == ""   }
    end

    context "42.itself" do

      it_behaves_like "hoge" do
        let(:f) { proc{42} }
      end
    end
  end

  describe "#*" do

    shared_examples_for "pure" do
      subject { proc(&l.f * g) }
      example { subject.(r).should == r.f(g.()) }
    end

    shared_examples_for "empty" do
      subject { proc(&l.f * g) }
      example { subject.(r).should == g.() }
    end


    context do
      let(:r) { double }
      before :each do
        r.stub(:f, &:succ)
      end

      context do
        it_behaves_like "pure" do
          let(:g) { proc{42} }
        end
      end

      context do
        it_behaves_like "empty" do
          let(:g) { proc{nil} }
        end
      end

      context do
        it_behaves_like "empty" do
          let(:g) { proc{false} }
        end
      end
    end
  end

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
