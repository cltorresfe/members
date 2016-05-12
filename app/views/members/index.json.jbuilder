json.array!(@members) do |member|
  json.extract! member, :id, :name, :address, :email, :phone, :estado
  json.url member_url(member, format: :json)
end
