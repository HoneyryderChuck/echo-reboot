# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe Node do
  describe "associations" do
    it { should have_many(:questions) }
    it { should have_many(:proposals) }
    it { should have_many(:improvements) }
    it { should have_many(:pro_arguments) }
    it { should have_many(:contra_arguments) }
    it { should have_many(:background_infos) }
  end

  describe "validations" do
    it { should validate_presence_of(:editorial_state_code) }
    it { should validate_presence_of(:info_type_code) }
    it { should ensure_inclusion_of(:editorial_state_code).in_array(StatementState.codes) }
    it { should ensure_inclusion_of(:info_type_code).in_array(InfoType.codes) }
  end
end