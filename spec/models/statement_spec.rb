# -*- encoding : utf-8 -*-
require "spec_helper"

describe Statement do
  class StatementTest < Statement
  end
  ActiveRecord::Schema.define do
    create_table :statement_tests, :force => true do |t|
      t.references :creator
      t.references :node
    end
  end

  subject { StatementTest.new }

  describe "associations" do
    it { should belong_to(:creator) }
    it { should belong_to(:node) }
    it { should have_one(:echo) }
  end

  describe "validations" do
    it { should validate_presence_of(:creator) }
    it { should validate_presence_of(:node) }
    it { should validate_presence_of(:echo) }
    #it { should validate_associated(:node) }
  end

  describe "privates" do
    describe "destroy_node" do
      subject { create(:question) }
      describe "when the statement is the only statement linked to the node" do
        it "should destroy the statement" do
          subject.destroy
          Node.find_by_id(subject.node.id).should be_nil
        end
      end
      describe "when there are more statements involved" do
        before do
          create(:question, node: subject.node)
          subject.reload
        end
        it "should keep the node" do
          subject.destroy
          Node.find_by_id(subject.node.id).should be_present
        end
      end
    end
  end
end