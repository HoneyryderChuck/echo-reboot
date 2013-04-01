# -*- encoding : utf-8 -*-
require "spec_helper"

describe Statements::QuestionsController do
  let(:user) { build_stubbed(:user) }
  before(:each) do
    controller.class.skip_before_filter :set_locale
    controller.stub! :authenticate_user! => true, :current_user => user
  end

  describe "show" do
    subject { build_stubbed(:question) }
    describe "html" do
      it "should load the question and render the right template" do
        Question.should_receive(:find).with("1").and_return(subject)
        get :show, id: 1
        response.should be_successful
        response.should render_template(:show)

      end
    end
  end

  describe "new" do
    describe "html" do
      it "should load a new question and render the new template" do
        get :new
        response.should be_successful
        response.should render_template(:new)
      end
    end

  end

  describe "post" do
    before { sign_in(user) }
    describe "when the parameters are set right" do
      let(:params) { {node: { document: {title: "TITLE", text: "TEXT", language_code: "en"}, topics: "top,pops" } } }
      describe "html" do
        it "should redirect to show" do
          post :create, statement: params
          flash.now[:notice].should be_present
          response.should be_redirect
        end
      end
    end
    describe "when the parameters are not set right" do
      let(:params) { {node: {topics: "top,pops" } } }
      describe "html" do
        it "should respond with error and render the new template" do
          post :create, statement: params
          response.should render_template(:new)
          response.should be_success

        end

      end
    end
  end
end