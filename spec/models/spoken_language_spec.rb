require 'spec_helper'

describe SpokenLanguage do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:language_level_code) }
    it { should validate_presence_of(:language_code) }
    it {
      FactoryGirl.create(:spoken_language)
      should validate_uniqueness_of(:language_code).scoped_to(:user_id)
    }
  end
end
