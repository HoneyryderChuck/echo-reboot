# -*- encoding : utf-8 -*-
require "spec_helper"

describe Statements::QuestionsController do
  let(:user) { build_stubbed(:user) }
  before(:each) do
    controller.class.skip_before_filter :set_locale, :read_permission, :write_permission
    controller.stub! :authenticate_user! => true, :current_user => user
  end

  describe "show" do
    subject { build_stubbed(:question) }
    let(:question) { assigns(:statement) }
    describe "when the record exists" do
      before do
        Question.should_receive(:find).with("1").and_return(subject)
      end
      it "should load the record in question" do
        get :show, id: 1
        question.should be_instance_of(Question)
        question.should be(subject)
      end
      describe "html" do
        it "render the new template" do
          get :show, id: 1
          response.should render_template(:show)

        end
      end
    end
    pending "when the record does not exist"
  end

  describe "new" do
    let(:question) { assigns(:statement) }
    it "should load a new Question" do
      get :new
      question.should be_instance_of(Question)
      question.should be_new_record
    end
    describe "html" do
      it "render the new template" do
        get :new
        response.should render_template(:new)
      end
    end
  end

  describe "edit" do
    subject { build_stubbed(:question) }
    let(:question) { assigns(:statement) }
    describe "when the record exists" do
      before do
        Question.should_receive(:find).with("1").and_return(subject)
      end
      it "should load the desired Question" do
        get :edit, id: 1
        question.should be_instance_of(Question)
        question.should be(subject)
      end
      describe "html" do
        it "render the edit template" do
          get :edit, id: 1
          response.should render_template(:edit)
        end
      end
    end
  end

  describe "create" do
    before { sign_in(user) }
    let(:question) { assigns(:statement) }
    describe "when the parameters are set right" do
      let(:params) { {node: { document: {title: "TITLE", text: "TEXT", language_code: "en"}, topics: "top,pops" } } }
      it "should create a new Question" do
        expect {
          post :create, statement: params
        }.to change(Question, :count).by(1)
      end
      it "should assign a persisted question" do
        post :create, statement: params
        question.should be_a(Question)
        question.should be_persisted
      end
      describe "html" do
        it "should redirect to show" do
          post :create, statement: params
          flash.now[:notice].should be_present
          response.should redirect_to(question_url(question))
        end
      end
    end
    describe "when the parameters are not set right" do
      let(:params) { {node: {topics: "top,pops" } } }
      it "should assign a non-persisted question" do
        post :create, statement: params
        question.should be_a(Question)
        question.should_not be_persisted
        question.should_not be_valid
      end
      describe "html" do
        it "should respond with error and render the new template" do
          post :create, statement: params
          response.should render_template(:new)
        end

      end
    end
  end

  describe "update" do
    before { sign_in(user) }
    subject { create(:question) }
    let(:question) { assigns(:statement) }
    describe "when the parameters are set right" do
      let(:params) { {node: { document: {title: "NEW TITLE", text: "NEW TEXT", language_code: "en"}, topics: "top,pops" } } }
      it "should load the needed question" do
        put :update, id: subject.id,  statement: params
        question.id.should be(subject.id)
      end
      it "should create a new Document" do
        expect {
          put :update, id: subject.id, statement: params
        }.to change(Document, :count).by(1)
      end
      describe "html" do
        it "should redirect to show" do
          put :update, id: subject.id, statement: params
          flash.now[:notice].should be_present
          response.should redirect_to(question_url(question))
        end
      end
    end
    describe "when the parameters are not set right" do
      let(:params) { {node: { document: {title: "NEW TITLE" }, topics: "top,pops" } } }
      it "should assign a non-persisted question" do
        put :update, id: subject.id, statement: params
        question.should be_a(Question)
        question.should_not be_valid
      end
      describe "html" do
        it "should respond with error and render the edit template" do
          put :update, id: subject.id, statement: params
          response.should render_template(:edit)
        end

      end
    end
  end

  describe "destroy" do
    before { sign_in(user) }
    subject { create(:question) }
    let(:question) { assigns(:statement) }
    it "should load the needed question" do
      delete :destroy, id: subject.id
      question.id.should be(subject.id)
    end
    it "should remove the question" do
      subject # eager loading for the counter to be activated
      expect {
        delete :destroy, id: subject.id
      }.to change(Question, :count).by(-1)
    end
    describe "html" do
      it "should redirect to index" do
        delete :destroy, id: subject.id
        flash.now[:notice].should be_present
        response.should redirect_to(questions_url)
      end
    end
  end

end