# -*- encoding : utf-8 -*-
require "spec_helper"

describe TagTranslation do

  describe "associations" do
    it { should belong_to(:tag) }
  end
  describe "validations" do
    it { should validate_presence_of(:language_code) }
    it { should validate_presence_of(:tag) }
    it { should validate_presence_of(:value) }
    it { should validate_uniqueness_of(:value).scoped_to(:tag_id, :language_code) }
  end

  describe "scopes" do
    before(:all) do
      @tag1 = FactoryGirl.create(:tag_translation, language_code: I18n.default_locale.to_s, value: "Bangus")
      @tag2 = FactoryGirl.create(:tag_translation, language_code: I18n.default_locale.to_s, value: "Bang")
      @tag3 = FactoryGirl.create(:tag_translation, language_code: I18n.default_locale.to_s, value: "angus")
      @tag4 = FactoryGirl.create(:tag_translation, language_code: I18n.default_locale.to_s, value: "ungus")
    end
    after(:all) do
      DatabaseCleaner.clean
    end
    describe "with_value" do
      it "should present the right results" do
        TagTranslation.with_value("Bang").should == [@tag2]
      end
    end
    describe "with_values" do
      it "should present the right results" do
        TagTranslation.with_values(["Bang", "angus"], :en).should ==[@tag2, @tag3]
      end
    end
    describe "with_value_like" do
      it "should present the right results" do
        TagTranslation.with_value_like("Bang").should == [@tag1, @tag2]
      end
    end

    describe "with_values_like" do
      it "should present the right results" do
        TagTranslation.with_values_like(["Bang", "ung"], :en).should == [@tag1, @tag2, @tag4]
      end
    end

  end
end