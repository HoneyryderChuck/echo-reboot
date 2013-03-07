# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :echo do
    visitor_count 0
    supporter_count 0
    association :echoable, factory: :question
  end
end