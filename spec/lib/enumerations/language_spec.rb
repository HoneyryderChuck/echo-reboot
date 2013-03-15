# -*- encoding : utf-8 -*-
require "spec_helper"

describe Language do

  it "should return enumeration code" do
    Language.send(:enumeration_code).should == "language"
  end

end