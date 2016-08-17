FactoryGirl.define do
  factory :match, class: Match do
    date      { Faker::Business.credit_card_expiry_date }
    finished  { false }
  end
end
