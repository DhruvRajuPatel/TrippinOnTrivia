json.array!(@questions) do |question|
  json.extract! question, :id, :title, :rating
  json.url question_url(question, format: :json)
end
