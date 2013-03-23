# -*- encoding : utf-8 -*-
autoload :ContextValidator, Rails.root.join("lib/extensions/validators/context_validator")

module Models
  autoload :Taggable, Rails.root.join("lib/extensions/models/taggable")

  ActiveRecord::Base.send :include, Taggable
end

