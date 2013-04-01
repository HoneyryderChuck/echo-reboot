class Statements::StatementsController < ApplicationController

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
