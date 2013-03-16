# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe Profile do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should ensure_length_of(:about_me).is_at_most(1024) }
    it { should ensure_length_of(:motivation).is_at_most(1024) }
  end
end