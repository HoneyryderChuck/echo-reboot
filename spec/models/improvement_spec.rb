# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe Improvement do
  describe "associations" do
    it { should belong_to(:proposal) }
    it { should have_and_belong_to_many(:alternatives) }
    it { should have_many(:background_infos) }
    it { should have_many(:follow_up_questions) }
  end

  describe "validations" do
    it { should validate_presence_of(:proposal) }
  end
end