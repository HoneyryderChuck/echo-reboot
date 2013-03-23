# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :tao_tag do
    tag_context_code { TagContext.all.sample.code }
    association :tag, factory: :tag
  end
end