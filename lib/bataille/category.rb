# coding: utf-8
module Bataille
  class Category
    attr_accessor :words, :name
    def initialize(name, words=[])
      @name = name
      @words = words
    end

    def &(category)
      words = self.words.product(category.words).map { |x| x.join(" ") }
      name = "#{@name} x #{category.name}"
      self.class.new(name, words)
    end

    def google_search(limit=10)
      ResultSet.new(
        self.words.map do |word|
          Search.google_search(word, limit)
        end,
        @name
      )
    end
  end
end
