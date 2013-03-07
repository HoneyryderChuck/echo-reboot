class Improvement < Statement

  belongs_to :proposal
  has_and_belongs_to_many :alternatives, class_name: "Improvement", association_foreign_key: :alternative_id, join_table: :improvement_alternatives

  has_many :background_infos, as: :statement
  has_many :follow_up_questions, as: :statement

  validates :proposal, presence: true
end