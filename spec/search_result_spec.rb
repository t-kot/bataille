# coding: utf-8
require 'spec_helper'

describe Bataille::SearchResult do
  include_context 'make 10 sites'
  subject { Bataille::SearchResult.new(sites, "hoge") }

  describe '#find_by' do
    context 'when the matching record exists' do
      let(:site) { Bataille::Site.new(url: "http://url1.jp") }
      it { subject.find_by(:url, site).should be_instance_of(Bataille::Site) }
    end

    context 'when the matching record does not exist' do
      let(:site) { Bataille::Site.new(url: "http://url11.jp") }
      it { subject.find_by(:url, site).should_not be }
    end

    context 'when target argument is passed with regexp' do
      it { subject.find_by(:url, /jp$/).should be }
      it { subject.find_by(:url, /com$/).should_not be }
    end

    context 'when target argument is passed with string' do
      it { subject.find_by(:url, "jp").should be }
      it { subject.find_by(:url, "com").should_not be }
      it { subject.find_by(:url, "jp", perfect: true).should_not be }
    end
  end
end
