# -*- encoding : utf-8 -*-
class Document < ActiveRecord::Base
  belongs_to :node
  belongs_to :author, class_name: "User"
  belongs_to :previous_document, class_name: 'Document'
  belongs_to :incorporated_statement, polymorphic: true
  belongs_to :locked_user, class_name: "User"

  has_enumerated :language
  has_enumerated :action, class_name: 'StatementAction'



  validates :title, presence: true, length: { maximum: 101 }
  validates :text, :node, :author, presence: true
  validates :current, uniqueness: {scope: [:node_id, :language_code] }


  scope :by_preferred_language, proc { |languages_list| where(language_code: languages_list).order("FIND_IN_SET(language_code, '#{languages_list.join(",")}')") }

  before_validation :set_previous_document, :set_action

  # Returns if the document is an original or a translation
  def original?
    !previous_document_id?
  end


  # Document locking mechanisms
  def valid_lock_period ; 1.hours ; end
  private :valid_lock_period

  def locked?
    locked_user.present? and locked_at? and locked_at >= 1.hours.ago
  end

  def locked_for?(user)
    locked? and not locked_user.eql?(user)
  end

  def lock!(user)
    self.locked_user = user
    self.locked_at = Time.now
    save
  end

  def unlock!
    self.locked_user = nil
    self.locked_at = nil
    save
  end


  private
  def set_previous_document
    self.previous_document ||= self.node.current_document if self.node.present?
  end

  def set_action
    self.action ||= self.previous_document.nil? ? StatementAction[:created] : StatementAction[:updated]
  end
end