class Statements::QuestionsController < Statements::StatementsController



  private

  def new_statement
    Question.new(creator: current_user,
                 node: Node.new(editorial_state: StatementState[:new]))
  end
end
