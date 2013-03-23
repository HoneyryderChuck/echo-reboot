# -*- encoding : utf-8 -*-
module Models
  module Taggable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def acts_as_taggable(*contexts)
        allowed_contexts = contexts.map(&:to_sym)
        raise "Invalid context!!" unless allowed_contexts.all?{|context| TagContext.all.map(&:code).include?(context.to_s) }

        class_eval do
          has_many :tao_tags, as: :tao, dependent: :destroy
          has_many :tags, through: :tao_tags

          validates :tao_tags, :context => { in: allowed_contexts }
        end
      end

    end
  end

end