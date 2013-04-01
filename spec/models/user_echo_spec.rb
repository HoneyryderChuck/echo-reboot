# -*- encoding : utf-8 -*-
require "spec_helper"

describe UserEcho do
  describe "associations" do
    it { should belong_to(:echo) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:echo) }
    it { create(:user_echo) ; should validate_uniqueness_of(:user_id).scoped_to(:echo_id) }
  end
end