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
      subject.should_receive(:editorial_state=).with(StatementState[:published])
    end
    after { subject.publish }
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
        subject.should_receive(:documents).and_return(:scope)
        subject.current_documents
      end
    end
    describe "#current_document" do
      let(:document) { mock(:document) }
      it "should get the document in the current language from the current documents" do
        scope.should_receive(:where).with(language: I18n.locale).and_return(document)
        subject.should_receive(:current_documents).and_return(scope)
        subject.current_document.should == document
      end
    end
  end
end
