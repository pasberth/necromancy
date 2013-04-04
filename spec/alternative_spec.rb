require 'slam'

class AlternativeDunk < Slam::Dunk
  include ::Slam::Alternative
end

describe AlternativeDunk do

  let(:l) { described_class.new }
  let(:d) { double }
  before :each do
    d.stub(:f, &f)
  end

  shared_examples_for "pure" do

    describe "#*" do
      subject { proc(&l.f * proc{r}) }
      before(:each) { d.should_receive(:f) }
      example { subject.(d).should == f.(r) }
    end

    describe "#|" do
      subject { proc(&l | f) }
      before(:each) { f.should_not_receive(:call) }
      example { subject.(r).should == r }
    end
  end

  shared_examples_for "empty" do

    describe "#*" do
      subject { proc(&l.f * proc{r}) }
      before(:each) { d.should_not_receive(:f) }
      example { subject.(d).should == r }
    end

    describe "#|" do
      subject { proc(&l | f) }
      before(:each) { f.should_receive(:call).twice }
      example { subject.(r).should == f.(r) }
    end
  end

  it_behaves_like "empty" do
    let(:r) { nil }
    let(:f) { ->(r){:OK} }
  end

  it_behaves_like "empty" do
    let(:r) { false }
    let(:f) { ->(r){:OK} }
  end

  it_behaves_like "pure" do
    let(:r) { true }
    let(:f) { ->(r){:OK} }
  end

  it_behaves_like "pure" do
    let(:r) { 0 }
    let(:f) { ->(r){:OK} }
  end

  it_behaves_like "pure" do
    let(:r) { [] }
    let(:f) { ->(r){:OK} }
  end

  it_behaves_like "pure" do
    let(:r) { {} }
    let(:f) { ->(r){:OK} }
  end

  it_behaves_like "pure" do
    let(:r) { "" }
    let(:f) { ->(r){:OK} }
  end
end
