json.array!(@families) do |family|
  json.extract! family, :id, :name, :married_at, :address, :phone, :city, :country, :church_id
  json.url family_url(family, format: :json)
end
