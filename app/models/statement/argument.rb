class Argument < Statement
  self.abstract_class = true

  belongs_to :proposal

  has_many :background_infos, as: :statement
  has_many :follow_up_questions, as: :statement

  validates :proposal, presence: true
end