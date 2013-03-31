# coding: utf-8
require 'spec_helper'

describe Bataille::Analytics do
  include_context 'make 10 sites'
  let(:search_result) { Bataille::SearchResult.new(sites, "hoge") }
  let(:site) { Bataille::Site.new(url: "http://url1.jp") }
  subject { search_result.analyze(site) }

  describe '#rate' do
  end
end
