# -*- encoding : utf-8 -*-
module Models
  module Taggable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def acts_as_taggable(*contexts)
        allowed_contexts = contexts.map(&:to_sym)
        raise "Invalid context!!" unless allowed_contexts.all?{|context| TagContext.codes.include?(context.to_s.singularize) }

        class_eval do
          has_many :tao_tags, as: :tao, dependent: :destroy
          has_many :tags, through: :tao_tags

          validates :tao_tags, :context => { in: allowed_contexts }

          allowed_contexts.each do |context|
            define_method context do
              tao_table = tao_tags.klass.arel_table
              tags.joins(:tao_tags).where(tao_table[:tag_context_code].eq(context.to_s.singularize)).map(&:locale)
            end
          end
        end
      end

    end
  end

end