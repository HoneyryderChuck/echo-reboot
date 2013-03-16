# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :document do
    title { Faker::Lorem.sentence }
    text  { Faker::Lorem.paragraph }
    language_code { Language.codes.sample }
    action_code   { StatementAction.codes.sample }
    association :author, factory: :user
    current true
    after(:build) do |document|
      document.node ||= build(:node, documents: [document])
    end

  end
end