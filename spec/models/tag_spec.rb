# -*- encoding : utf-8 -*-
require "spec_helper"

describe Tag do

  describe "associations" do
    it { should have_many(:tao_tags) }
    it { should have_many(:tag_translations) }
  end

  describe "#locale" do
    let(:tag) { create(:tag, tag_translations: [build(:tag_translation, language: Language[:de], value: "Lili Marlene"),
                                                            build(:tag_translation, language: Language[:en], value: "Lulu Marli")]) }
    before do
      @old_default_locale = I18n.default_locale
      I18n.default_locale = :en
    end
    after do
      I18n.default_locale = @old_default_locale
    end
    describe "when a translation exists for the existing locale" do
      let(:value) { tag.locale(:de) }
      it "should present the respective value" do
        value.should == "Lili Marlene"
      end
    end

    describe "when the translation does not exist for the given locale" do
      let(:value) { tag.locale(:cz) }
      it "should present the value of the default language" do
        value.should == "Lulu Marli"
      end
    end

  end

end