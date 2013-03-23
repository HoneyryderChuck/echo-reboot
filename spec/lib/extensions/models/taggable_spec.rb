# -*- encoding : utf-8 -*-
require "spec_helper"

describe Models::Taggable do

  class Models::Taggable::TaggableTest < ActiveRecord::Base
    acts_as_taggable :affections
  end

  ActiveRecord::Schema.define do
    create_table :taggable_tests, :force => true
  end

  subject { Models::Taggable::TaggableTest.new }
  describe "associations" do
    it { should have_many(:tao_tags) }
    it { should have_many(:tags) }
  end
  describe "validations" do
    it "should validate the context by the given" do
      subject.tao_tags << FactoryGirl.build(:tao_tag, tao: subject, tag_context_code: "engagement")
      subject.should_not be_valid
      subject.errors[:tao_tags].should be_present
      subject.errors[:tao_tags].should include(I18n.t("errors.messages.invalid_context"))
    end
  end
  it "should have a method called affectionss" do
    subject.should respond_to(:affections)
  end
  describe "for an existing tagged taggable" do
    subject {Models::Taggable::TaggableTest.create }
    before do
      tag1 = FactoryGirl.create(:tag, tag_translations: [FactoryGirl.build(:tag_translation, language: Language[:en], value: "translation1")] )
      tag2 = FactoryGirl.create(:tag, tag_translations: [FactoryGirl.build(:tag_translation, language: Language[:en], value: "translation2")] )
      tag3 = FactoryGirl.create(:tag, tag_translations: [FactoryGirl.build(:tag_translation, language: Language[:en], value: "translation3")] )
      subject.tao_tags << FactoryGirl.create(:tao_tag, tao: subject, tag_context: TagContext[:affection], tag: tag1)
      subject.tao_tags << FactoryGirl.create(:tao_tag, tao: subject, tag_context: TagContext[:affection], tag: tag2)
      subject.tao_tags << FactoryGirl.create(:tao_tag, tao: subject, tag_context: TagContext[:affection], tag: tag3)
    end
    it "I should call affections and get all the available tags" do
      subject.affections.should == %w(translation1 translation2 translation3)
    end
  end

end