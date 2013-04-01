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
end
