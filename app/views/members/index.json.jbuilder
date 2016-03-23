json.array!(@members) do |member|
  json.extract! member, :id, :name, :adress, :email, :phono, :status
  json.url member_url(member, format: :json)
end
