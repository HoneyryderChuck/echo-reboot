# -*- encoding : utf-8 -*-
class TaoTag < ActiveRecord::Base

  belongs_to :tag
  belongs_to :tao, polymorphic: true

  has_enumerated :tag_context

  validates :tag, :tao, presence: true
  validates :tag_id, uniqueness: { scope: [:tao_type, :tao_id, :tag_context_code] }
end