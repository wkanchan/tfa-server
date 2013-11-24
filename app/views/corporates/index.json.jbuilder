json.array!(@corporates) do |corporate|
  json.extract! corporate, :id, :name, :status, :key
  json.url corporate_url(corporate, format: :json)
end
