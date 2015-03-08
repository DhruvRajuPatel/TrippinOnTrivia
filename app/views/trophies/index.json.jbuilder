json.array!(@trophies) do |trophy|
  json.extract! trophy, :id
  json.url trophy_url(trophy, format: :json)
end
