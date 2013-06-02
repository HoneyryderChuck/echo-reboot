class Proposal < Statement
  belongs_to :question
  has_many :improvements,                           dependent: :destroy
  has_many :pro_arguments,                          dependent: :destroy
  has_many :contra_arguments,                       dependent: :destroy

  has_and_belongs_to_many :alternatives, class_name: "Proposal", association_foreign_key: :alternative_id, join_table: :proposal_alternatives

  has_many :follow_up_questions, as: :statement,    dependent: :destroy


  validates :question, presence: true
end

