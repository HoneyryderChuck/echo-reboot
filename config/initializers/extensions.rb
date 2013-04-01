# -*- encoding : utf-8 -*-
autoload :ContextValidator,             Rails.root.join("lib/extensions/validators/context_validator")
autoload :CollectionEmptinessValidator, Rails.root.join("lib/extensions/validators/collection_emptiness_validator")

module Models
  autoload :Taggable, Rails.root.join("lib/extensions/models/taggable")

  ActiveRecord::Base.send :include, Taggable
end

