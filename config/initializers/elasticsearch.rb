url = ENV['BONSAI_URL'] || 'http://localhost:9200'
Elasticsearch::Model.client = Elasticsearch::Client.new(url: url)
