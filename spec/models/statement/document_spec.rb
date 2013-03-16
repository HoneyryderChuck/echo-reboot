# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe Document do
  describe "associations" do
    it { should belong_to(:node) }
    it { should belong_to(:author) }
    it { should belong_to(:previous_document) }
    it { should belong_to(:incorporated_statement) }
    it { should belong_to(:locked_by) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_most(101) }
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:node) }
    it {
      FactoryGirl.create(:document)
      should validate_uniqueness_of(:current).scoped_to(:language_code)
    }
  end

end