class Statement < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :creator,  class_name: "User"
  has_one    :echo,     as: :echoable,        dependent: :destroy
  belongs_to :node,     dependent: :destroy

  validates :node, :creator, :echo, presence: true
  validates :node, associated: true


  # form handlers
  def node=(attrs)
    attrs.is_a?(Hash) ? (node || Node.new).assign_attributes(attrs) : super
  end

end

