class BackgroundInfo < Statement
  belongs_to :statement, polymorphic: true

  validates :statement, presence: true
end