# -*- encoding : utf-8 -*-
autoload :Enumeration,      Rails.root.join('lib/enumerations/enumeration')
autoload :AboutCategory,    Rails.root.join('lib/enumerations/about_category')
autoload :InfoType,         Rails.root.join('lib/enumerations/info_type')
autoload :Language,         Rails.root.join('lib/enumerations/language')
autoload :LanguageLevel,    Rails.root.join('lib/enumerations/language_level')
autoload :OrganizationType, Rails.root.join('lib/enumerations/organization_type')
autoload :StatementAction,  Rails.root.join('lib/enumerations/statement_action')
autoload :StatementState,   Rails.root.join('lib/enumerations/statement_state')
autoload :TagContext,       Rails.root.join('lib/enumerations/tag_context')


module Enumerations
  module HasEnumerated
    def has_enumerated(attribute, opts={})
      klass = opts[:class_name] || attribute.to_s.classify
      validates :"#{attribute}_code", presence: true unless opts[:allow_nil]
      validates :"#{attribute}_code", inclusion: { in: klass.constantize.codes, allow_nil: opts[:allow_nil] }

      define_method attribute do
        klass[send("#{attribute}_code")] unless send("#{attribute}_code").nil?
      end

      define_method :"#{attribute}=" do |value|
        send("#{attribute}_code=", value.code)
      end
    end
  end
end

ActiveRecord::Base.extend(Enumerations::HasEnumerated)