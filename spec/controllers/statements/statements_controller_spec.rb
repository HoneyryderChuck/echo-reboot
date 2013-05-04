# -*- encoding : utf-8 -*-
require "spec_helper"

describe Statements::StatementsController do
  describe "filters" do
    describe "#read_permission" do
      let(:statement) { mock(:statement) }
      let(:current_user) { mock(:user) }
      before do
        controller.instance_variable_set("@statement", statement)
        controller.stub! current_user: nil
      end
      describe "when the statement is published" do
        before do
          statement.stub_chain :node, :published? => true
        end
        it "should pass" do
          controller.send(:read_permission).should be_true
        end
      end
      describe "when the statement is not published" do
        before do
          statement.stub_chain :node, :published? => false
        end
        it "should check write permissions" do
          controller.should_receive(:write_permission)
          controller.send(:read_permission)
        end
      end
    end

    describe "#write_permission" do
      let(:statement) { mock(:statement) }
      let(:current_user) { mock(:user) }
      before do
        controller.instance_variable_set("@statement", statement)
        controller.stub! current_user: nil
      end
      describe "when there is no current user" do
        it "should not pass" do
          controller.send(:write_permission).should be_false
        end
      end
      describe "and there is a current user" do
        let(:authors) { mock(:authors) }
        before do
          controller.stub! current_user: current_user
          statement.stub_chain :node, :authors, :by_language => authors
        end
        describe "and the user is an author from one of the previous documents" do
          before do
            authors.should_receive(:include?).with(current_user).and_return(true)
          end
          it "should pass" do
            controller.send(:write_permission).should be_true
          end
        end
        describe "and the iser is not an author from one of the previous documents" do
          before do
            authors.should_receive(:include?).with(current_user).and_return(false)
          end
          it "should not pass" do
            controller.send(:write_permission).should be_false
          end
        end
      end
    end
  end
end