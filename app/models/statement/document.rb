# -*- encoding : utf-8 -*-
class Document < ActiveRecord::Base
  belongs_to :node
  belongs_to :author, class_name: "User"
  belongs_to :previous_document, class_name: 'StatementDocument'
  belongs_to :incorporated_statement, polymorphic: true
  belongs_to :locked_by, class_name: "User", foreign_key: 'locked_by'

  has_enumerated :language
  has_enumerated :action, class_name: 'StatementAction'



  validates :title, presence: true, length: { maximum: 101 }
  validates :text, :node, :author, presence: true
  validates :current, uniqueness: {scope: [:language_code] }


  default_scope where(current: true)
end