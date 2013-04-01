class Statements::StatementsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!, except: [:index, :show]

  def index

  end

  def show
    @statement = fetch_statement
    render
  end

  def new
    @statement = new_statement
    @document = @statement.node.documents.build
    render
  end

  def create
    @statement = new_statement
    @statement.assign_attributes(params[:statement])
    # set document author
    @statement.node.documents.each{|d| d.author = current_user }
    @statement.save
    flash[:notice] = I18n.t("discuss.messages.created", type: @statement.class.model_name.human) if @statement.persisted?
    respond_with(@statement)
  end

end
