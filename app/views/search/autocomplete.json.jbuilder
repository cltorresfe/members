json.members do |json|
  json.array! @members do |member|
    json.id member.id
    json.full_name truncate(member.full_name, length: 28)
    json.avatar_url member.avatar? ? member.avatar.url : '/assets/default_avatar.png'
    json.url member_path(member.id)
  end
end