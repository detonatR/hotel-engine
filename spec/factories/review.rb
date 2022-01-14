# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    association :reviewable, factory: :book
    user
    rating { rand(1..5) }
    description { Faker::Lorem.paragraph }
  end
end
