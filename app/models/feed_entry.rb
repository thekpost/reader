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
  
  #CUSTOM SCOPES  
  #OTHER METHODS
  
  def is_read
    self.last_clicked_on.blank? ? false : true
  end
  
  def self.update_from_feed(feed_app)
    feed_url = feed_app.app_url  
    updated_feed = Feedzirra::Feed.update(feed_url)
    if updated_feed.updated?
      add_entries(feed_app, updated_feed.new_entries)
    end
    feed_app.update_attributes(is_pending: "done", last_processed: Time.now, rss_last_modified_at: updated_feed.last_modified)
  end
    
  def self.add_entries(u, entries)
    entries.each do |entry|
      unless exists? guid: entry.id
        u.feed_entries.create!(
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
