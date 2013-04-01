# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :node do
    editorial_state_code { StatementState.codes.sample }
    after(:build) do |node|
      node.documents = [build(:document, node: node)] if node.documents.empty?
    end
  end
end