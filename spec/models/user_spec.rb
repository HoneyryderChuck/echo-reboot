# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe User do
  describe "associations" do
    it { should have_many(:spoken_languages) }
  end
end