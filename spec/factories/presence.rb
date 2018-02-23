FactoryBot.define do
  factory :presence do
    goals    { rand(1..4) }
    assist   { rand(1..3) }
    team_id  { rand(1..5) }
    presence { true }
  end
end
