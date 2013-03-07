class Proposal < Statement
  belongs_to :question
  has_many :improvements
  has_many :pro_arguments
  has_many :contra_arguments

  has_and_belongs_to_many :alternatives, class_name: "Proposal", association_foreign_key: :alternative_id, join_table: :proposal_alternatives

  has_many :background_infos, as: :statement
  has_many :follow_up_questions, as: :statement


  validates :question, presence: true
end

