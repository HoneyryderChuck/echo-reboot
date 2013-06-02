class Argument < Statement
  self.abstract_class = true

  belongs_to :proposal

  has_many :follow_up_questions, as: :statement,    dependent: :destroy

  validates :proposal, presence: true
end