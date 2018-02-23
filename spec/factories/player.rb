FactoryBot.define do
  factory :player, class: Player do
    name      { Faker::Name.name }
    nickname  { Faker::Superhero.name }
    active    { true }
  end
end
