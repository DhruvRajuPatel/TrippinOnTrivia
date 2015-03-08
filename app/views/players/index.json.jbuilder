json.array!(@players) do |player|
  json.extract! player, :id, :meter
  json.url player_url(player, format: :json)
end
