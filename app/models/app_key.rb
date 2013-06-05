class AppKey < ActiveRecord::Base
  
  #GEMS USED
  #ACCESSORS
  attr_accessible :app_url, :entity_name, :is_pending, :last_processed, :last_requested_processing, :user_id, :incoming_channel, :rss_last_modified_at, :categories, :html_url, :sort_id, :favicon, :colour
  
  attr_accessor :incoming_channel
  
  #ASSOCIATIONS
  belongs_to  :user
  has_many    :feed_entries   , dependent: :destroy
  has_many    :tag_entries    , dependent: :destroy
  
  #VALIDATIONS
  validates :user_id,         :presence => true  
  validate  :no_duplicate_accounts_please, :on => :create
  validates :app_url, :format => URI::regexp(%w(http https)), :presence => true
  
  #CALLBACKS
  before_create :before_create_set
  after_create :after_create_set
  
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS
  
  def fav
    if self.html_url.blank?
      return nil
    else
      return self.html_url + "/favicon.ico"
    end
  end
  
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
      
  def replace_blank_with_nil
    self.app_url = nil        if self.app_url == ""
    self.entity_name = nil    if self.entity_name == ""
  end
  
  #JOBS
  #PRIVATE
  
  private
  
  def no_duplicate_accounts_please
    app_keys = AppKey.where(app_url: self.app_url, user_id: self.user_id)
    if !app_keys.first.blank?
      app_keys.each do |a|
        errors.add(:app_url, "duplicate RSS url")
      end
    end
    true
  end  
    
  def after_create_set
    Delayed::Job.enqueue Dj1.new(self.id, true)
    true
  end
  
  def before_create_set
    self.entity_name = URI(self.app_url).host
  	self.last_requested_processing = Time.now
  	true
  end
    
end
