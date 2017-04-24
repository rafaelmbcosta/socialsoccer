# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    url         { Faker::Internet.url }
    description { Faker::Lorem.sentence }
  end
end
