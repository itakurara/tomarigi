url = ENV['BONSAI_URL'] || ENV['ELASTICSEARCH_URL']
Elasticsearch::Model.client = Elasticsearch::Client.new(url: url)
