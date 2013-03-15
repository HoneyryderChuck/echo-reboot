# -*- encoding : utf-8 -*-
require "spec_helper"

describe TagContext do

  it "should return enumeration code" do
    TagContext.send(:enumeration_code).should == "tag_context"
  end

end