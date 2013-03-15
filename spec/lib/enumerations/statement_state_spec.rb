# -*- encoding : utf-8 -*-
require "spec_helper"

describe StatementState do

  it "should return enumeration code" do
    StatementState.send(:enumeration_code).should == "statement_state"
  end

end