json.array!(@users) do |user|
  json.extract! user, :id, :corporate_id, :passcode
  json.url user_url(user, format: :json)
end
