json.array!(@seasons) do |season|
  json.extract! season, :id, :number
  json.url season_url(season, format: :json)
end
