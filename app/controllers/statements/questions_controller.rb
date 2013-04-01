class Statements::QuestionsController < Statements::StatementsController



  private

  def fetch_statement
    Question.find(params[:id])
  end

  def new_statement
    Question.new(creator: current_user,
                 node: Node.new(editorial_state: StatementState[:new]))
  end
end
