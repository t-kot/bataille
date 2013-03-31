# coding: utf-8
module Bataille
  class Site
    attr_accessor :rank, :title, :url, :description

    def initialize(args={})
      @rank, @title, @url, @description =
        args[:rank], args[:title], args[:url], args[:description]
    end
  end
end
