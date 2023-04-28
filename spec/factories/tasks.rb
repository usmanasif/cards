# spec/factories/tasks.rb

FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    user

    trait :completed do
      is_completed { true }
    end

    trait :incomplete do
      is_completed { false }
    end
  end
end
