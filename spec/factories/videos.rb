# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :video do
    url         { Faker::Internet.url }
    description { Faker::Lorem.sentence }
  end
end
