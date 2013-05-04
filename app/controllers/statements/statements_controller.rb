class Statements::StatementsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!, except: [:index, :show]

  def index

  end

  def show
    @statement = fetch_statement
    @document = @statement.node.current_document
    render
  end

  def new
    @statement = new_statement
    @document = @statement.node.new_document
    render
  end

  def edit
    @statement = fetch_statement
    @document = @statement.node.new_document
    render
  end

  def create
    @statement = new_statement
    @statement.assign_attributes(params[:statement])
    # set document author
    @statement.node.documents.each{|d| d.author = current_user }
    flash[:notice] = I18n.t("discuss.messages.created", type: @statement.class.model_name.human) if @statement.save
    respond_with(@statement)
  end

  def update
    @statement = fetch_statement
    @statement.assign_attributes(params[:statement])
    @document = @statement.node.documents.last
    if @document.new_record?
      @document.author = current_user
    else
      @document = @statement.node.current_document
    end
    flash[:notice] = I18n.t("discuss.messages.updated", type: @statement.class.model_name.human) if @statement.save
    respond_with(@statement)
  end

  def destroy
    @statement = fetch_statement
    @statement.destroy
    flash[:notice] = I18n.t("discuss.messages.deleted", type: @statement.class.model_name.human) if @statement.destroyed?
    respond_with(@statement)
  end

end
