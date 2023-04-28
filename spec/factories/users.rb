# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.unique.name }
    last_name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { 0 }
  end
end
