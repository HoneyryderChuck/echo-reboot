# -*- encoding : utf-8 -*-
require 'spec_helper'

describe UserHelper do
  describe "#languages_by_proficiency" do
    let(:user) { mock(:user) }
    describe "when the user does have the knowledge" do
      before do
        user.stub_chain :spoken_languages, :at_least_intermediate => [mock(:spoken, language: "LANGUAGE")]
      end
      it "should return the languages" do
        helper.languages_by_proficiency(user, :intermediate).should == ["LANGUAGE"]
      end
    end
    describe "when the user doesn't have the knowledge" do
      before do
        user.stub_chain :spoken_languages, :at_least_intermediate => []
        I18n.stub! locale: :default
        Language.should_receive(:[]).with(:default).and_return("DEFAULT")
      end
      it "should return the default language" do
        helper.languages_by_proficiency(user, :intermediate).should == ["DEFAULT"]
      end
    end
  end
end
