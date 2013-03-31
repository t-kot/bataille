# coding: utf-8
require 'spec_helper'

describe Bataille::Site do
  subject do
    Bataille::Site.new(
      rank: 1,
      title: "Test Title Test test",
      url: "http://test.com",
      description: "test test this is test",
      keyword: "test"
    )
  end

  describe '#word_count' do
    it { subject.word_count(:description).should eq 3 }
    it { subject.word_count(:title).should eq 3 }
    it { subject.word_count(:url).should eq 1 }

    it "should raise argument error" do
      expect {
        subject.word_count(:hoge)
      }.to raise_error(ArgumentError)
    end
  end
end
