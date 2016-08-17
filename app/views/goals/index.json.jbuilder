json.array!(@goals) do |goal|
  json.extract! goal, :id, :player_id, :match_id, :goals
  json.url goal_url(goal, format: :json)
end
