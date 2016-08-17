FactoryGirl.define do
  factory :player, class: Player do
    name      { Faker::Name.name }
    nickname  { Faker::Superhero.name }
  end
end
