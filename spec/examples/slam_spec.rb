require 'slam'

describe Slam::Dunk do

  let(:l) { described_class.new }

  example do
    [:foo, :bar, :baz].map(&l.to_s . upcase).
      should == ["FOO", "BAR", "BAZ"]
  end

  example do
    [:foo, :hoge, :bar, :fuga].select(&l.to_s . length > 3).
      should == [:hoge, :fuga]
  end

  example do
    qstr = "hoge=fuga&foo=bar"
    Hash[qstr.split(?&).map &l.split(?=)].
      should == {"hoge"=>"fuga", "foo"=>"bar"}
  end

  example do
    (1..5).map(&l ** 2).
      should == [1, 4, 9, 16, 25]
  end

  example do
    %w[c++ lisp].map(&(l + "er").upcase).
      should == ["C++ER", "LISPER"]
  end

  example do
    %w[c++ lisp].map(&l.upcase + "er").
      should == ["C++er", "LISPer"]
  end

  example do
    procs = %w(succ pred odd?).map &l.to_sym . to_proc
    procs.map(&l.call(1)).
      should == [2, 0, true]
  end
end
