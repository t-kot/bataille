require 'bataille'
require 'webmock/rspec'
require 'shared_context'

def build_dom_for(sites)
  sites.each.map do |site|
    <<-CONTENT
    <result#{site.rank} class="g">
      <div class="r">#{site.title}</div>
      <div class="kv">
        <cite>#{site.url}</cite>
      </div>
      <div class="st">#{site.description}</div>
    </result#{site.rank}>
    CONTENT
  end.inject(:+)
end

def stub_response_for(sites)
  stub_request(:get, %r!#{Bataille::Search::SEARCH_URL_PREFIX}\?q=[^&]*\&start=[^&]*!).
    to_return(
      body: "<html><body>"+build_dom_for(sites)+"</body></html>"
    )
end
