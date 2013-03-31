# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Statements::StatementsHelper do
  describe "#supporters_number" do
    let(:statement) { mock(:statement) }
    describe "when statement is new" do
      before { statement.stub! :new_record? => true }
      it "should be one" do
        helper.supporters_number(statement).should include("1")
      end
    end
    describe "when statement is not new" do
      before {
        statement.stub! :new_record? => false
        statement.stub_chain :echo, :supporter_count => 20
      }
      it "should be one" do
        helper.supporters_number(statement).should include("20")
      end
    end
  end
end
