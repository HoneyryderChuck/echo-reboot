# -*- encoding : utf-8 -*-
module Models
  module Taggable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def acts_as_taggable(*contexts)
        allowed_contexts = contexts.map(&:to_s).map(&:singularize)
        raise "Invalid context!!" unless allowed_contexts.all?{|context| TagContext.codes.include?(context) }

        class_eval do
          has_many :tao_tags, as: :tao, dependent: :destroy
          has_many :tags, through: :tao_tags
          has_many :tag_translations, through: :tags

          validates :tao_tags, :context => { in: allowed_contexts }

          allowed_contexts.each do |context|
            define_method context.pluralize do
              tao_table = tao_tags.klass.arel_table
              tags.joins(:tao_tags).where(tao_table[:tag_context_code].eq(context)).map(&:locale)
            end
            define_method "#{context.pluralize}=" do |cs_topics|
              cs_topics.split(",").each do |topic_tag|
                tag_tr = tag_translations.find_or_initialize_by_value_and_language_code(topic_tag, I18n.locale.to_s,
                                                                                       {tag: Tag.new} )
                tao_tags.build(tao: self, tag: tag_tr.tag, tag_context_code: context) if tag_tr.new_record?
              end
            end
          end
        end
      end

    end
  end

end