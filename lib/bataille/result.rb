# coding: utf-8
module Bataille
  class Result
    attr_accessor :rank, :title, :url, :description

    def initialize(rank, title, url, description)
      @rank, @title, @url, @description = rank, title, url, description
    end
  end
end
