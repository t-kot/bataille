# coding: utf-8
module Bataille
  class ResultSet
    attr_accessor :category
    include Enumerable

    def initialize(results, category)
      @results = results
      @category = category
    end

    def each
      @results.each { |r| yield r }
    end
  end
end
