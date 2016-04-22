json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :member_id, :ministry_id, :attendance_date, :present
  json.url attendance_url(attendance, format: :json)
end
