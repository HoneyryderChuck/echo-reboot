# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe Echo do

  describe "associations" do
    it { should belong_to(:echoable) }
    it { should have_many(:user_echos) }
  end

  describe "validations" do
    it { should validate_presence_of(:echoable) }
  end

  describe "callbacks" do
    describe "after" do
      describe "update" do
        subject{ create(:echo) }
        it "should update the counters" do
          subject.should_receive(:update_counters)
          subject.save
        end
      end
    end
  end

  describe "#update_counters" do
    subject{ create(:echo) }
    it "should update the counter columns right away" do
      subject.visitor_count.should == 0
      subject.user_echos.create(user: build(:user), visited: true)
      subject.update_counters
      subject.visitor_count.should == 1
      subject.supporter_count.should == 0
      subject.user_echos.create(user: build(:user), supported: true)
      subject.update_counters
      subject.supporter_count.should == 1
    end
  end

end