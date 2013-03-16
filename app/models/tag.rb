# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base

  has_many :tao_tags, dependent: :destroy
  has_many :tag_translations, dependent: :destroy

end