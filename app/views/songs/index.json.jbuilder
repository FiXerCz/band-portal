json.array!(@songs) do |song|
  json.extract! song, :id, :title, :lyrics, :composer
  json.url song_url(song, format: :json)
end
