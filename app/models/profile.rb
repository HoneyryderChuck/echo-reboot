# -*- encoding : utf-8 -*-
class Profile < ActiveRecord::Base

  belongs_to :user

  validates :user, presence: true
  validates :about_me, :motivation, length: { maximum: 1024, allow_nil: true }

  mount_uploader :avatar, AvatarUploader
end