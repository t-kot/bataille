# coding: utf-8
module Bataille
  class Site
    attr_accessor :rank, :title, :url, :description, :word

    def initialize(args={})
      @rank, @title, @url, @description, @keyword =
        args[:rank], args[:title], args[:url], args[:description], args[:keyword]
    end

    def word_count(attr)
      if [:title, :url, :description].include? attr.to_sym
        self.send(attr).scan(/#{@keyword}/i).length
      else
        raise ArgumentError
      end
    end
  end
end
