json.array!(@concerts) do |concert|
  json.extract! concert, :id
  json.url concerts_url(concert, format: :json)
end
