# -*- encoding : utf-8 -*-
require "./spec/spec_helper"

describe Question do
  describe "associations" do
    it { should belong_to(:follow_up_question) }
    it { should have_many(:proposals) }
    it { should have_many(:background_infos) }
    it { should have_many(:follow_up_questions) }
  end

end