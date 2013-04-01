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


  scope :by_preferred_language, proc { |languages_list| where(language_code: languages_list).order("FIND_IN_SET(language_code, '#{languages_list.join(",")}')") }

  # Returns if the document is an original or a translation
  def original?
    !previous_document_id?
  end


  # Document locking mechanisms
  def valid_lock_period
    1.hours
  end
  private :valid_lock_period

  def locked?(user)
    locked_by.present? and !locked_by.eql?(user) and locked_at >= 1.hours.ago
  end

  def lock!(user)
    self.locked_by = user
    self.locked_at = Time.now
    save
  end

  def unlock!
    self.locked_by = nil
    self.locked_at = nil
    save
  end
end