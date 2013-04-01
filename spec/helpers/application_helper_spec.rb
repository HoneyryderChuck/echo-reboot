# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ApplicationHelper do
  describe "#language_preference_list" do
    let(:user) { mock(:user) }
    before do
      I18n.stub! locale: "LOCALE"
      helper.stub! current_user: user
      user.stub_chain :spoken_languages, :by_language_level, :pluck => ["USER_LANGUAGES"]
      @statement = mock(:statement)
      @statement.stub_chain :node, :original_language, :code => "ORIGINAL"
    end
    it "should order the locale language, the current user spoken languages and the original language of the document" do
      helper.language_preference_list.should == ["LOCALE", "USER_LANGUAGES", "ORIGINAL"]
    end
  end
end
