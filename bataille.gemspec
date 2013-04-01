# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bataille/version'

Gem::Specification.new do |gem|
  gem.name          = "bataille"
  gem.version       = Bataille::VERSION
  gem.authors       = ["kotohata"]
  gem.email         = ["t.kotohata@gmail.com"]
  gem.description   = %q{Bataille is custom web searcher and utility for SEO}
  gem.summary       = %q{custom web searcher and utilify for SEO}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
