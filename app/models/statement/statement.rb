class Statement < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :creator,  class_name: "User"
  has_one    :echo,     as: :echoable,        dependent: :destroy

  validates :creator, :echo, presence: true
end
