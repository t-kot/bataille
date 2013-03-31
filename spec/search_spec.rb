# coding: utf-8
require 'spec_helper'

describe Bataille::Search do

  include_context 'make 10 sites response'

  before { stub_response_for(sites) }

  describe '.google_search' do
    context 'when limit is over 50' do
      it 'should raise limit error' do
        expect {
          Bataille::Search.google_search('hoge', 100)
        }.to raise_error(Bataille::Search::LimitError)
      end
    end

    context 'limit is specified' do
      subject { Bataille::Search.google_search('hoge', 20) }
      it { should have(20).results }
      its('word') { should eq 'hoge' }
    end

    context 'limit is not specified' do
      subject { Bataille::Search.google_search('hoge') }
      it { should have(10).results }
    end
  end

  describe '.fetch_result' do
    subject { Bataille::Search.fetch_result('hoge') }
    it { should have(10).site }
    its('first') { should be_instance_of(Bataille::Site) }
    its('first.url') { should eq "http://url1.jp" }
    its('last.url') { should eq "http://url10.jp" }
  end

  describe '.fetch_times_for' do
    it 'should round up to the nearest whole number' do
      Bataille::Search.send(:fetch_times_for, 3).should eq 1
      Bataille::Search.send(:fetch_times_for, 10).should eq 1
      Bataille::Search.send(:fetch_times_for, 21).should eq 3
    end
  end
end
