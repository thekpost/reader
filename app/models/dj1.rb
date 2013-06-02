class Dj1 < Struct.new(:akid)
  
  #WHEN A FEED IS FIRST ADDED
  
  def perform
    feed_app = AppKey.find(akid)
    feed = Feedzirra::Feed.fetch_and_parse(feed_app.app_url)
    feed_app.update_attributes(entity_name: feed.title)
    FeedEntry.add_entries(feed_app, feed.entries)
    feed_app.update_attributes(is_pending: "done", last_processed: Time.now, rss_last_modified_at: feed.last_modified)
  end
  
  #PRIVATE
  private
  
end