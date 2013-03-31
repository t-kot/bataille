# coding: utf-8
require 'spec_helper'

describe Bataille::Category do
  let(:category1) { Bataille::Category.new("animal", [ "cat", "dog"] ) }
  let(:category2) { Bataille::Category.new("country", [ "japan", "america" ]) }
  subject { category1 & category2 }

  describe "#&" do
    its(:words) { should =~ ["cat japan", "dog japan", "cat america", "dog america"] }
    its(:name) { should eq "animal x country" }
  end

  describe '#google_search' do
    include_context 'make 10 sites'
    before { stub_response_for(sites) }
    its('google_search') { should have(4).results }
    its('google_search') { should be_instance_of(Bataille::ResultSet) }
    its('google_search.category') { should eq "animal x country" }
  end
end
