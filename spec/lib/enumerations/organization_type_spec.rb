# -*- encoding : utf-8 -*-
require "spec_helper"

describe OrganizationType do

  it "should return enumeration code" do
    OrganizationType.send(:enumeration_code).should == "organization_type"
  end

end