json.array!(@churches) do |church|
  json.extract! church, :id, :name, :adress, :email, :phone
  json.url church_url(church, format: :json)
end
