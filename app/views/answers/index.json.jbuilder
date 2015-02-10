json.array!(@answers) do |answer|
  json.extract! answer, :id, :title, :is_correct
  json.url answer_url(answer, format: :json)
end
