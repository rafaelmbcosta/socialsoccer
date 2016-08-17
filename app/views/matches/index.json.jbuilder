json.array!(@matches) do |match|
  json.extract! match, :id, :date
  json.url match_url(match, format: :json)
end
