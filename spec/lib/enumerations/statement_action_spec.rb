# -*- encoding : utf-8 -*-
require "spec_helper"

describe StatementAction do

  it "should return enumeration code" do
    StatementAction.send(:enumeration_code).should == "statement_action"
  end

end