class FeedEntry < ActiveRecord::Base
  
  #GEMS USED
  #ACCESSORS
  attr_accessible :app_key_id, :guid, :is_star, :is_to_read, :last_clicked_on, :name, :published_at, :summary, :url, :user_id, :categories, :author, :content
  
  #ASSOCIATIONS
  belongs_to :app_key
  belongs_to :user
  has_many :tag_entries
  
  #VALIDATIONS
  validates :app_key_id, presence: true
  
  #CALLBACKS
  #SCOPES
  default_scope order: 'feed_entries.published_at DESC'
  scope :read,    where("last_clicked_on is not null")
  scope :to_read, where(is_to_read: true)
  scope :star,    where(is_star: true)
  
  #CUSTOM SCOPES  
  def self.by_user(u)
    where("app_key_id IN (?)", u.app_key_ids)
  end
  
  #OTHER METHODS
  
  def is_read
    self.last_clicked_on.blank? ? false : true
  end
  
  def self.add_entries(ak, entries)
    entries.each do |entry|
      unless exists? guid: entry.id
        ak.feed_entries.create!(
          name: entry.title,
          summary: entry.summary,
          content: entry.content,
          url: entry.url,
          published_at: entry.published.blank? ? Time.now : entry.published,
          author: entry.author,
          categories: entry.categories,
          guid: entry.id)
      end
    end
  end
  
  #PRIVATE
  private
  
end
