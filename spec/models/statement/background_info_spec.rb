# -*- encoding : utf-8 -*-
require "spec_helper"

describe BackgroundInfo do
  describe "associations" do
    it { should belong_to(:statement) }

  end

  describe "validations" do
    it { should validate_presence_of(:statement) }
    it { should validate_presence_of(:info_type_code) }
    it { should ensure_inclusion_of(:info_type_code).in_array(InfoType.codes) }
  end
end
