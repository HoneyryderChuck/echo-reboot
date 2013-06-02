class Question < Statement

  belongs_to :follow_up_question,                 dependent: :destroy
  has_many :proposals,                            dependent: :destroy
  has_many :follow_up_questions, as: :statement,  dependent: :destroy


end