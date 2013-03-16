# -*- encoding : utf-8 -*-
require "spec_helper"

describe FollowUpQuestion do
  describe "associations" do
    it { should have_one(:question) }
    it { should belong_to(:statement) }
  end

  describe "validations" do
    it { should validate_presence_of(:statement) }
  end
end