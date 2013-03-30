class User < ActiveRecord::Base
  has_many :spoken_languages


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable



  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me


  acts_as_taggable :affections, :engagements, :expertises, :decision_makings


  has_enumerated :last_login_language, class_name: "Language", allow_nil: true

  # Languages

  # Returns the preferred language to be used for the user
  # (degrade chain: mother_tounge -> last_login_language -> system default language).
  def preferred_language
    mother_tongues.first || self.last_login_language || Language[I18n.default_locale]
  end


  # Returns an array with the user's mother tongues.
  def mother_tongues
    spoken_languages.where(language_level_code: LanguageLevel[:mother_tongue].code).map(&:language)
  end
end
