# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :node do
    info_type_code { InfoType.codes.sample }
    editorial_state_code { StatementState.codes.sample }
  end
end