class Statements::StatementsController < ApplicationController

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

end
