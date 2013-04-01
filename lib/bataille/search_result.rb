# coding: utf-8
module Bataille
  class SearchResult
    attr_accessor :results, :word
    include Enumerable
    def initialize(results, word)
      @results, @word = results, word
    end

    def length
      @results.length
    end

    def each
      @results.each { |r| yield r }
    end

    def limit(n=1)
      self.class.new(@results[0..n-1])
    end
    alias :top :limit

    def where(conditions, opt={})
      conditions.inject(self) do |result,(key, value)|
        Bataille::SearchResult.new(finder(key, value, opt), @word)
      end
    end

    def find_by(match, site, opt={})
      finder(match, site, opt).first
    end

    private
    def finder(match, site, opt={})
      #
      # Bataille::Site instance or String are expected to site.
      #
      case site
      when Bataille::Site
        target = site.send(match)
      when String, Regexp
        target = site
      else
        raise ArgumentError
      end

      #
      # perfect matching if opt[:perfect] == true
      # default is ambiguous matching
      #
      # when target is regexp object, opt[:perfect] is ignored
      #
      if target.instance_of?(Regexp)
        result = self.find_all { |x| x.send(match) =~ target }
      else
        if opt[:perfect]
          result = self.find_all { |x| x.send(match) == target }
        else
          result = self.find_all { |x| x.send(match).include?(target) }
        end
      end

      #
      # if protocol is specified, matches results which have https protocol
      # default, any protocol matches
      #

      if opt[:protocol] == "https"
        result = result.find_all { |x| URI.parse(x.url).scheme == "https" }
      elsif opt[:protocol] == "http"
        result = result.find_all { |x| URI.parse(URI.encode(x.url)).scheme.nil? }
      end
      result
    end
  end
end
