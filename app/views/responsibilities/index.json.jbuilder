json.array!(@responsibilities) do |responsibility|
  json.extract! responsibility, :id, :name
  json.url responsibility_url(responsibility, format: :json)
end
