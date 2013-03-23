class BackgroundInfo < Statement
  belongs_to :statement, polymorphic: true

  validates :statement, presence: true

  has_enumerated :info_type

  def info_type
    @info_type ||= InfoType[info_type_code]
  end
end