if Rails.env.development?
  url = ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200/'
  Elasticsearch::Model.client = Elasticsearch::Client.new log: true, url: url
end
