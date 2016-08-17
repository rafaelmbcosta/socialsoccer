FactoryGirl.define do
  factory :presence do
    goals   { rand(4) }
    team_id { rand(5)+1 }
  end
end
