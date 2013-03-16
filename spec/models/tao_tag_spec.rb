# -*- encoding : utf-8 -*-
require "spec_helper"

describe TaoTag do
  describe "associations" do
    it { should belong_to(:tag) }
    it { should belong_to(:tao) }
  end

  describe "validations" do
    it { should validate_presence_of(:tag_context_code) }
    it { should validate_presence_of(:tag) }
    it { should validate_presence_of(:tao) }
    #it {
    #  TaoTag.create(tag: Tag.new, tao: FactoryGirl.build(:user))
    #  should validate_uniqueness_of(:tag_id).scoped_to([:tao_type, :tao_id, :tag_context_code])
    #}
  end
end