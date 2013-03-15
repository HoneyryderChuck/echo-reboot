# -*- encoding : utf-8 -*-
require "spec_helper"

describe AboutCategory do

  it "should return enumeration code" do
    AboutCategory.send(:enumeration_code).should == "about_category"
  end

end