# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :node do
    editorial_state_code { StatementState.codes.sample }
  end
end