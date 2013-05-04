# -*- encoding : utf-8 -*-
require "spec_helper"

describe Node do
  describe "associations" do
    it { should have_many(:questions) }
    it { should have_many(:proposals) }
    it { should have_many(:improvements) }
    it { should have_many(:pro_arguments) }
    it { should have_many(:contra_arguments) }
    it { should have_many(:background_infos) }
  end

  describe "validations" do
    it { should validate_presence_of(:editorial_state_code) }
    it { should ensure_inclusion_of(:editorial_state_code).in_array(StatementState.codes) }
  end

  describe "#published?" do
    describe "when editorial state is published" do
      before { subject.editorial_state = StatementState[:published] }
      it "should respond based on the editorial state" do
        subject.published?.should be_true
      end
    end
    describe "when editorial state is published" do
      before { subject.editorial_state = StatementState[:new] }
      it "should respond based on the editorial state" do
        subject.published?.should be_false
      end
    end
  end

  describe "#publish" do
    it "should mark it as published" do
      subject.publish
      subject.editorial_state.code == "published"
    end
  end
  describe "#publish!" do
    it "should persist the publishing" do
      subject.should_receive(:publish)
      subject.should_receive(:save)
    end
    after { subject.publish! }
  end

  describe "document methods" do
    let(:scope) { mock(:scope) }
    describe "#new_document" do
      before{ I18n.stub! :locale => :bang }
      let(:document) { mock(:document) }
      let(:new_document) { mock(:new_document) }
      describe "when there is a current document" do
        before do
          subject.should_receive(:current_document).with(:bang).and_return(document)
          document.should_receive(:dup).and_return(new_document)
        end
        it "should duplicate it to a new instance" do
          subject.new_document.should be(new_document)
        end
      end
      describe "when there is no current document" do
        before do
          subject.should_receive(:current_document).with(:bang).and_return(nil)
        end
        it "should create an empty document" do
          subject.documents.should_receive(:build).and_return(new_document)
          subject.new_document.should be(new_document)
        end
      end
    end
    describe "#current_documents" do
      it "should scope by current" do
        scope.should_receive(:where).with(current: true)
        subject.should_receive(:documents).and_return(scope)
        subject.current_documents
      end
    end
    describe "#current_document" do
      let(:document) { mock(:document) }
      it "should get the document in the current language from the current documents" do
        scope.should_receive(:where).with(language_code: I18n.locale).and_return([document])
        subject.should_receive(:current_documents).and_return(scope)
        subject.current_document.should == document
      end
    end
    describe "#original_document" do
      let(:original) { mock(:original) }
      it "should get the document which doesn't have any previous document" do
        scope.should_receive(:where).with(previous_document_id: nil).and_return([original])
        subject.should_receive(:documents).and_return(scope)
        subject.original_document.should == original
      end
    end
    describe "#original_language" do
      it "should delegate to the original document" do
        subject.should_receive(:original_document).and_return(mock(:document, language: "LANG"))
        subject.original_language.should == "LANG"
      end
    end
  end

  describe "scopes" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    before(:all) do
      @node = create(:node, documents: [ create(:document, language_code: "en", author: user1),
                                         create(:document, language_code: "de", author: user2),
                                         create(:document, language_code: "es", author: user3) ])
    end
    after(:all) do
      DatabaseCleaner.clean
    end
    describe ".authors_by_language" do
      it "should only deliver the authors by document language" do
        @node.authors.by_language(:en).should == [user1]
        @node.authors.by_language(:de).should == [user2]
        @node.authors.by_language(:es).should == [user3]
      end
    end
  end
end
