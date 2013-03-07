class FollowUpQuestion < Statement
  has_one :question
  belongs_to :statement, polymorphic: true

  validates :statement, presence: true
end