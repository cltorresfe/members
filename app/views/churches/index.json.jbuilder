json.array!(@churches) do |church|
  json.extract! church, :id, :name, :address, :email, :phone
  json.url church_url(church, format: :json)
end
