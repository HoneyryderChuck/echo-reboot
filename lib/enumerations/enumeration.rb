# -*- encoding : utf-8 -*-
class Enumeration

  attr_reader :code

  def initialize(code)
    @code = code
  end


  #def value
  #  I18n.t("enumerations.#{self.class.plural_code}.#{code}")
  #end


  def self.all
    definition_file[enumeration_code].map{|code|self.new(code)}
  end

  private

  def self.enumeration_code
    self.name.underscore
  end

  def self.definition_file
      @definition_file ||= YAML.load(File.new(Rails.root.join("config", "settings", "enumerations.yml")))
  end

end