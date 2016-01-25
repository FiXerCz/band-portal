json.array!(@albums) do |album|
  json.extract! album, :id, :title, :released
  json.url album_url(album, format: :json)
end
