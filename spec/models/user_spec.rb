# -*- encoding : utf-8 -*-
require "spec_helper"

describe User do
  describe "associations" do
    it { should have_many(:spoken_languages) }
  end

  describe "#mother_tongues" do
    let(:languages) { mock(:languages) }
    let(:mother_tongues) { [mock(:tongue, language: "Mother Tongue")] }
    it "should fetch the language from the saved mother tongues" do
      subject.should_receive(:spoken_languages).and_return(languages)
      languages.should_receive(:where).with(language_level_code: "mother_tongue").and_return(mother_tongues)
      subject.mother_tongues.should == ["Mother Tongue"]
    end
  end

  describe "#preferred_language" do
    describe "if the user has a mother tongue" do
      before { subject.stub! mother_tongues: ["MOTHER TONGUE"] }
      it "should return it" do
        subject.preferred_language.should == "MOTHER TONGUE"
      end
    end
    describe "if the user hasn't a mother tongue yet" do
      before { subject.stub! mother_tongues: [] }
      describe "but already has a saved last login language" do
        before { subject.stub! last_login_language: "LANGUAGE" }
        it "should return it" do
          subject.preferred_language.should == "LANGUAGE"
        end
      end
      describe "and it doesn't have a last login language" do
        before { subject.stub! last_login_language: nil }
        it "should return the default language" do
          subject.preferred_language.code.should == Language[I18n.default_locale].code
        end
      end
    end
  end

end