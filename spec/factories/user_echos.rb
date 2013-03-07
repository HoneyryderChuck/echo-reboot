# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user_echo do
    visited false
    supported false
    association :user, factory: :user

    after(:build) do |u_echo|
      u_echo.echo ||= build(:echo)
    end
  end
end