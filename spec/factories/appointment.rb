status_enum = ['pending', 'approved', 'in progress', 'finalized']

FactoryBot.define do
  factory :appointment do
    association :user, factory: :user
    chore { Faker::Lorem.word }
    date { 3.days.from_now }
    status { status_enum[rand(0..3)] }
    provider_id { Faker::Number.number(digits: 3) }
    cost { Faker::Number.number(digits: 2) }
  end
end
