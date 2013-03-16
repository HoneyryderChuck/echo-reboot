# -*- encoding : utf-8 -*-
class SpokenLanguage < ActiveRecord::Base
  belongs_to :user

  has_enumerated :language
  has_enumerated :language_level

  validates :user, :language_code, :language_level_code, presence: true
  validates :language_code, uniqueness: { scope: :user_id }
end