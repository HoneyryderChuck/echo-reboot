class Question < Statement

  belongs_to :follow_up_question
  has_many :proposals
  has_many :background_infos, as: :statement
  has_many :follow_up_questions, as: :statement


end