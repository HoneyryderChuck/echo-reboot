# -*- encoding : utf-8 -*-
class Echo < ActiveRecord::Base

  belongs_to :echoable, polymorphic: true
  has_many :user_echos

  validates :echoable, presence: true

  after_save :update_counters, on: :update

  def update_counters
    update_column :visitor_count,
                  user_echos.count(:conditions => { :visited => true })
    update_column :supporter_count,
                  user_echos.count(:conditions => { :supported => true })
  end

end