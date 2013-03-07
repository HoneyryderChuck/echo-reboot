# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :question do
    association :creator, factory: :user
    association :node,    factory: :node
    after(:build) do |question|
      question.echo ||=  build(:echo, echoable: question)
    end
  end
end