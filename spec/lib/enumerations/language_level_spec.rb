# -*- encoding : utf-8 -*-
require "spec_helper"

describe LanguageLevel do

  it "should return enumeration code" do
    LanguageLevel.send(:enumeration_code).should == "language_level"
  end

end