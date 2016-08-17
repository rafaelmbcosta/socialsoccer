# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :season do
    sequence(:number)
  end
end
