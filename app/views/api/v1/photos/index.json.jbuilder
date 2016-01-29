json.array!(@photos) do |photo|
  json.extract! photo, :id, :user_id, :photo, :target_user_id
  json.url photo_url(photo, format: :json)
end
