class AppKey < ActiveRecord::Base
  
  #GEMS USED
  #ACCESSORS
  attr_accessible :app, :app_api_token, :app_password, :app_url, :app_username, :entity_name, :is_pending, :last_processed, :last_request_user_id, :last_requested_processing, :user_id, :incoming_channel, :error_message, :app_account_name, :dashboard_id, :range, :genre, :is_advertisement, :rss_last_modified_at, :categories, :html_url, :sort_id
  
  attr_accessor :incoming_channel
  
  #ASSOCIATIONS
  belongs_to :user
  belongs_to :last_requestor, :class_name => 'User', :foreign_key => "last_request_user_id"
  has_many :feed_entries, dependent: :destroy
  has_many :tag_entries, dependent: :destroy
  
  #VALIDATIONS
  validates :entity_name,     :presence => true
  #TODO - need validation that entity_name does not have SPACE in case app is FORMHUB
  validates :user_id,         :presence => true  
  validate  :no_duplicate_accounts_please, :on => :create
  validates :app_url, :format => URI::regexp(%w(http https)), uniqueness: { case_sensitive: false }, :presence => true
  
  #CALLBACKS
  before_create :before_create_set
  after_create :after_create_set
  
  #SCOPES
  scope :pending, where(:is_pending => "pending")
  scope :phase1, where(:is_pending => "phase1_done")
  scope :to_delete, where(:is_pending => "to_delete")
  
  #CUSTOM SCOPES

  #OTHER METHODS
  
  def self.import(u, a_json)
    a_json.each do |t|
      url_u = t[0].gsub("feed/http://", "http://")
      if u.app_keys.where(app_url: url_u).first.blank?
        z = AppKey.new(user_id: u.id, app_url: url_u, entity_name: t[1], categories: t[3], html_url: t[2], sort_id: t[4])
        z.save
        if !t[5].blank?
          if !t[5].first.blank?
            t[5].each do |t_g|
              tag_o = u.tags.where(name: t_g).first
              if !tag_o.blank?
                TagEntry.import(z.id, tag_o.id)
              end              
            end
          end
        end
      end
    end
  end
  
  def self.without_tags(u)
    response_obj = []
    u.app_keys.each do |a|
      if a.tag_entries.first.blank?
        response_obj << a
      end
    end
    return response_obj
  end
  
  def to_s
    self.entity_name
  end
  
  def reset_pending_params
    if self.delayed_job.blank?
      self.update_attributes(is_pending: nil)
    end
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
  
  def is_pending?
    if self.is_fhub? or self.is_ga?
      return self.is_pending == "pending" ? true : false
    else
      self.projects.each do |p|
        return true if p.is_pending?
      end
    end
    return false
  end
  
  def phase1?
    if self.is_fhub? or self.is_ga?
      return self.is_pending == "phase1_done" ? true : false
    else
      self.projects.each do |p|
        return true if p.phase1?
      end
    end
    return false
  end
  
  def to_delete?
    return self.is_pending == "to_delete" ? true : false
  end
  
  def replace_blank_with_nil
    self.app_url = nil        if self.app_url == ""
    self.entity_name = nil    if self.entity_name == ""
  end
  
  #JOBS
  #PRIVATE
  
  private
  
  def no_duplicate_accounts_please
    app_keys = AppKey.where(app_url: self.app_url)
    if !app_keys.first.blank?
      app_keys.each do |a|
        errors.add(:app_url, "duplicate RSS url")
      end
    end
    true
  end  
    
  def after_create_set
    Delayed::Job.enqueue Dj1.new(self.id)
    true
  end
  
  def before_create_set
    url = URI(self.app_url)
    self.is_pending = "pending"
  	self.last_requested_processing = Time.now
  end
    
end
