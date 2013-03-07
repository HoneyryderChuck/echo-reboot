class Statement < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :creator, class_name: "User"

  validates :creator, presence: true
end
