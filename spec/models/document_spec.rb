# -*- encoding : utf-8 -*-
require "spec_helper"

describe Document do
  describe "associations" do
    it { should belong_to(:node) }
    it { should belong_to(:author) }
    it { should belong_to(:previous_document) }
    it { should belong_to(:incorporated_statement) }
    it { should belong_to(:locked_user) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_most(101) }
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:node) }
    it {
      create(:document)
      should validate_uniqueness_of(:current).scoped_to(:node_id, :language_code)
    }
  end

  describe "callbacks" do
    describe "before" do
      describe "validation" do
        it "should call #set_action and #set_previous_document" do
          subject.should_receive(:set_action)
          subject.should_receive(:set_previous_document)
          subject.valid?
        end
      end
    end
  end

  describe "#set_previous_document" do
    let(:current) { build_stubbed(:document) }
    let(:node) { mock(:node, current_document: current) }
    it "should assign the node current document" do
      subject.stub! node: node
      subject.send(:set_previous_document)
      subject.previous_document.should == current
end
  end
  describe "#set_action" do
    describe "when there's not a previous document" do
      before { subject.stub! previous_document: nil }
      it "should be set to created" do
        subject.send(:set_action)
        subject.action.code.should == "created"
      end
    end
    describe "when there's a previous document" do
      before { subject.stub! previous_document: mock(:document) }
      it "should be set to updated" do
        subject.send(:set_action)
        subject.action.code.should == "updated"
      end
    end
    it "should not do anything if the action is already set" do
      action = mock(:action)
      subject.stub! action: action
      subject.send(:set_action)
      subject.action.should == action

    end

  end


  describe "scopes" do
    describe ".by_preferred_language" do
      before(:all) do
        @doc1 = create(:document, language_code: "es")
        @doc2 = create(:document, language_code: "en")
        @doc3 = create(:document, language_code: "de")
      end
      after(:all) do
        DatabaseCleaner.clean
      end
      it "should order by the given language order" do
        Document.by_preferred_language([:en, :de, :es]).should == [@doc2, @doc3, @doc1]
        Document.by_preferred_language([:de, :en, :es]).should == [@doc3, @doc2, @doc1]
        Document.by_preferred_language([:de, :en]).should == [@doc3, @doc2]
      end
    end
  end


  describe "#original?" do
    it "should be dependent of whether the document has a previous document" do
      subject.stub! :previous_document_id? => false
      subject.original?.should be_true
      subject.stub! :previous_document_id? => true
      subject.original?.should be_false
    end
  end

  describe "Locking Methods" do
    describe "#valid_lock_period" do
      it "should be 1 hour" do
        subject.send(:valid_lock_period).should == 1.hours
      end
    end
    describe "#lock!" do
      let(:user) { mock(:user) }
      it "should persist the locking changes" do
        subject.should_receive(:locked_user=).with(user)
        subject.should_receive(:locked_at=).with(instance_of(Time))
        subject.should_receive(:save)
      end
      after { subject.lock!(user) }
    end
    describe "#unlock!" do
      it "should unlock the document and persist it" do
        subject.should_receive(:locked_user=).with(nil)
        subject.should_receive(:locked_at=).with(nil)
        subject.should_receive(:save)
      end
      after { subject.unlock! }
    end
    describe "#locked_for?" do
      let(:user) { mock(:user) }
      describe "if the document hasn't been locked by any user" do
        before { subject.stub! locked_user: nil }
        it { subject.should_not be_locked_for(user) }
      end
      describe "if the document has been locked by some user" do
        describe "and the same user is trying to acquire the lock" do
          before { subject.stub! locked_user: user }
          it { subject.should_not be_locked_for(user) }
        end
        describe "and a different user is trying to acquire the lock" do
          before { subject.stub! locked_user: mock(:another_user) }
          describe "and the lock time has run out" do
            before { subject.stub! locked_at: 2.hours.ago }
            it { subject.should_not be_locked_for(user) }
          end
          describe "and the lock time is still going" do
            before { subject.stub! locked_at: 30.minutes.ago, :locked_at? => true }
            it { subject.should be_locked_for(user) }
          end
        end
      end
    end
  end

end