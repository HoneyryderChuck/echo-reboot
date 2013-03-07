# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe BackgroundInfo do
  describe "associations" do
    it { should belong_to(:statement) }
  end

  describe "validations" do
    it { should validate_presence_of(:statement) }
  end
end
