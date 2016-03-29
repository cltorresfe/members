json.array!(@members) do |member|
  json.extract! member, :id, :name, :adress, :email, :phone, :estado
  json.url member_url(member, format: :json)
end
