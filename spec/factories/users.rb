# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
  end
end