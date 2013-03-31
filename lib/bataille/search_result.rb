# coding: utf-8
module Bataille
  class SearchResult
    attr_accessor :results, :word
    include Enumerable
    def initialize(results, word)
      @results, @word = results, word
    end
    def each
      @results.each { |r| yield r }
    end

    def limit(n=1)
      self.class.new(@results[0..n-1])
    end

    alias :top :limit
  end
end
