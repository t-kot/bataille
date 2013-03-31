# coding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'

module Bataille
  class Search
    SEARCH_URL_PREFIX = "http://www.google.co.jp/search"
    MAX_SEARCH_LIMIT = 50

    class << self

      def google_search(word, limit=10)
        unless (1..MAX_SEARCH_LIMIT).include?(limit)
          raise LimitError, limit > MAX_SEARCH_LIMIT ? "search results should be under 50" : "something wrong with limit parameter"
        end
        results = 0.upto(fetch_times_for(limit)).map do |n|
          fetch_result(word, n*10)
        end.inject(:+)

        SearchResult.new(results[0..(limit-1)], word)
      end

      def fetch_result(word, start=0)
        charset = nil
        html = open(search_url(word, start)) do |f|
          charset = f.charset
          f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        doc.css('.g').each_with_index.map do |result, i|
          Site.new(
            rank: i+1+start,
            title: result.css('.r').text,
            url: result.css('.kv').search('cite').text,
            description: result.css('.st').text
          )
        end
      end

      private
      def search_url(word, start)
        url = SEARCH_URL_PREFIX + "?q=#{word}"
        url << "&start=#{start}" if start
        #url << "&ie=UTF-8"
        URI.encode(url)
      end

      def fetch_times_for(n)
        (n-1)/10 + 1
      end
    end

    class LimitError < StandardError; end
  end
end
