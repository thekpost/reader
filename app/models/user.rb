class User < ActiveRecord::Base

  #GEMS USED
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable#, :omniauthable
  include SentientUser
  
  #ACCESSORS
  attr_accessible :email, :password, :remember_me, :reset_password_token, :reset_password_sent_at, :unconfirmed_email, :authentication_token, :authentication_id_at_signup, :name, :unconfirmed_email, :confirmation_token, :confirmed_at, :confirmation_sent_at, :plan_genre, :sign_in_count, :last_sign_in_at, :is_paying_customer, :username, :slug, :description
  
  attr_accessible :incoming_channel
  attr_accessor :incoming_channel
  
  #ASSOCIATIONS
  has_many :app_keys        , :dependent => :destroy
  has_one :authentication   , :dependent => :destroy
  has_many :tags, :dependent => :destroy
  
  #NESTED 
  #VALIDATIONS
  validates :password , :length => { :within => 8..40, on: :create }, :presence => { on: :create }, 
                        :format => { :with => Safai::Regex::PASSWORD, :message => "too weak", on: :create }
  validates :email    , :uniqueness => { case_sensitive: false }, :length => { :minimum => 3 }, 
                        :format => { :with => Safai::Regex::EMAIL, :message => "invalid format"}, :presence => true
  validates :name     , :presence => true, :if => :non_device_forms, :length => { :minimum => 3 }, :if => :non_device_forms
  validates :username , :uniqueness => { case_sensitive: false }, presence: true, :length => { :minimum => 3 }
  
  #CALLBACKS
  before_create :before_create_set
  after_create  :after_create_set
  
  #SCOPES  
  #OTHER METHODS
  
  def reauthenticate_google?
    self.authentication.reauthenticate_google?
  end
  
  def token
    self.authentication.token
  end
  
  def to_s
    name.blank? ? self.email : self.name
  end
    
  def is_admin?
    (email == "rp@pykih.com" or email == "ritvij.j@gmail.com") ? true : false
  end
  
  def feed_entries_count(g, akid)
    if g == "h"
      return FeedEntry.where("app_key_id IN (?) and feed_entries.last_clicked_on is not null", self.app_keys.pluck("app_keys.id")).count.to_s
    elsif g == "r"
      return FeedEntry.where("app_key_id IN (?) and feed_entries.is_to_read = true", self.app_keys.pluck("app_keys.id")).count.to_s
    elsif g == "s"
      return FeedEntry.where("app_key_id IN (?) and feed_entries.is_star = true", self.app_keys.pluck("app_keys.id")).count.to_s
    elsif g == "a"
      return FeedEntry.where("app_key_id IN (?)", self.app_keys.pluck("app_keys.id")).where("feed_entries.app_key_id = ?", akid).count.to_s
    else
      return FeedEntry.where("app_key_id IN (?)", self.app_keys.pluck("app_keys.id")).count.to_s
    end
  end

  #JOBS
  #PRIVATE
  private
  
  def before_create_set
    self.authentication_token = SecureRandom.hex
    true
  end
  
  def after_create_set
    true
  end
  
  def non_device_forms
    incoming_channel == "change_password" ? true : false
  end
    
end
