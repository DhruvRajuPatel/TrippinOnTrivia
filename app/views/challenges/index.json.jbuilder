json.array!(@challenges) do |challenge|
  json.extract! challenge, :id
  json.url challenge_url(challenge, format: :json)
end
