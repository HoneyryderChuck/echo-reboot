# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :tag_translation do
    association :tag, factory: :tag
    language_code { Language.codes.sample }
    value "Despina Vandi"
  end
end