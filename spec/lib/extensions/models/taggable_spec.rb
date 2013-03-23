# -*- encoding : utf-8 -*-
require "spec_helper"

describe Models::Taggable do

  class Models::Taggable::TaggableTest < ActiveRecord::Base
    acts_as_taggable :affection
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

end