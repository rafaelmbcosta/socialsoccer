# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :season do
    sequence(:number)
  end
end
