# -*- encoding : utf-8 -*-
require "spec_helper"

describe InfoType do

  it "should return enumeration code" do
    InfoType.send(:enumeration_code).should == "info_type"
  end

end