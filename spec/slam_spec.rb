require 'spec_helper'
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
end
