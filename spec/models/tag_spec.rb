# -*- encoding : utf-8 -*-
require "spec_helper"

describe Tag do

  describe "associations" do
    it { should have_many(:tao_tags) }
    it { should have_many(:tag_translations) }
  end
end