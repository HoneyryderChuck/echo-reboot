# -*- encoding : utf-8 -*-
require "spec_helper"

describe BackgroundInfo do
  describe "associations" do
    it { should belong_to(:content) }

  end

  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:external_url) }
    it { should allow_value("http://weird.com").for(:external_url) }
    it { should_not allow_value("foo").for(:external_url) }
    it { should validate_presence_of(:info_type_code) }
    it { should ensure_inclusion_of(:info_type_code).in_array(InfoType.codes) }
  end
end
