# coding: utf-8
require 'rubygems'
require 'json'
require 'nokogiri'
require 'open-uri'
#require 'bataille/result'
require_relative './result'

module Bataille
  class SearchResult
    include Enumerable
    SEARCH_URL_PREFIX = "http://www.google.co.jp/search"
    MAX_SEARCH_LIMIT = 50

    def initialize(results)
      @results = results
    end

    def length
      @results.length
    end

    def each
      @results.each { |r| yield r }
    end

    def limit(n)
      self.select { |x| x.rank < n+1 }
    end

    class << self

      def google_search(word, limit=10)
        raise LimitExceed, "search results should be under 50" if limit > MAX_SEARCH_LIMIT
        results = []
        0.upto(MAX_SEARCH_LIMIT/10 - 1).map do |n|
          results += fetch_result(word, n*10)
        end
        self.new(results[0..(limit-1)])
      end

      def fetch_result(word, start=0)
        charset = nil
        html = open(search_url(word, start)) do |f|
          charset = f.charset
          f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        doc.css('.g').each_with_index.map do |result, i|
          page_rank = i+1+start
          page_title =  result.css('.r').text
          page_url =  result.css('.kv').search('cite').text
          page_description = result.css('.st').text
          Bataille::Result.new(page_rank, page_title, page_url, page_description)
        end
      end

      private
      def search_url(word, start)
        url = SEARCH_URL_PREFIX + "?q=#{word}"
        url << "&start=#{start}" if start
        url << "&ie=UTF-8"
      end
    end

    class LimitExceed < StandardError; end
  end
end
