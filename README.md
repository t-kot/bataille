# Bataille

Bataille is smart custom web searcher and analyzer for SEO.

## Installation

Add this line to your application's Gemfile:

    gem 'bataille'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bataille

## Usage


### Search
- - -

	results = Bataille::Search.google_search("test") #=> #<Bataille::SearchResult>
	
	site = results.first #=> #<Bataille::Site>
	site.url #=> "test.jp/"
	site.title #=> "test title"
	site.description #=> "test description"
	site.rank #=> 1 //search result page ranking
	
or you can specify the number of result, default length is 10

	result = Bataille::Search.google_search("test", 20)
	result.length # 20
	
---
you can use finder for search result

	results = Bataille::Search.google_search("test")
	results.where(title: "hoge")
	results.where(description: "fuga")
	results.where(url: /com$/)
	# you can chain finders
	results.where(title: "hoge").where(url: /com$/)
	# or
	results.where({title: "hoge", url: /com$/})
	
Bataille::SearchResult#where returns another Bataille::SearchResult instance.

if you want to get the only 1 result, use '#find_by'
	
	results.find_by(:url, /com$/) #=> #<Bataille::Site>


	

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
