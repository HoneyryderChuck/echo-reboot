# -*- encoding : utf-8 -*-
class UserEcho < ActiveRecord::Base
  belongs_to :echo
  belongs_to :user

  validates :user, :echo, presence: true
  validates :user_id,      uniqueness: { scope: :echo_id }

end