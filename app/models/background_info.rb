class BackgroundInfo < Statement
  belongs_to :content, polymorphic: true

  validates :content, :external_url, presence: true
  validates :external_url, format: { with: URI::regexp(["http", "https"]) }

  has_enumerated :info_type

  def info_type
    @info_type ||= InfoType[info_type_code]
  end
end