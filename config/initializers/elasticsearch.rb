config = {
  host: 'http://localhost:9200'
}

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
