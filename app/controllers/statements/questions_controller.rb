class Statements::QuestionsController < Statements::StatementsController



  private

  def fetch_statement
    Question.find(params[:id])
  end

  def new_statement
    Question.new(creator: current_user, node: Node.new(editorial_state: StatementState[:new]), echo: Echo.new)
  end

  def question_params
    params.require(:statement).permit(node: [:topics, :editorial_state_code, document: [:title, :text, :language_code]])
  end
end
