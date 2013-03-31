# coding: utf-8
module Bataille
  class Analytics
    def initialize(search_result, site)
      @search_result = search_result
      @site = site
    end

    def rate
      @search_result.detect { |x| x.url == @site.url }.rank
    end
  end
end
