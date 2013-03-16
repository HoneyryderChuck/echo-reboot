# -*- encoding : utf-8 -*-
class Node < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :improvements, dependent: :destroy
  has_many :pro_arguments, dependent: :destroy
  has_many :contra_arguments, dependent: :destroy
  has_many :background_infos, dependent: :destroy

  has_many :documents, :dependent => :destroy


  has_enumerated :info_type
  has_enumerated :editorial_state, class_name: "StatementState"

  mount_uploader :statement_image, StatementImageUploader

  def info_type
    @info_type ||= InfoType.new(info_type_code)
  end

  def editorial_state
    @editorial_state ||= StatementState.new(editorial_state_code)
  end

  def destroy
    super unless %w(questions proposals improvements pro_arguments contra_arguments background_infos).any? { |a| self.send(a).count > 0 }
  end
end