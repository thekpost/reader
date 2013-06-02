class Dj1 < Struct.new(:akid)
  
  #WHEN A FEED IS FIRST ADDED
  
  def perform
    feed_app = AppKey.find(akid)
    feed = Feedzirra::Feed.fetch_and_parse(feed_app.app_url)
    if feed.class.to_s != "Fixnum"
      feed_app.update_attributes(entity_name: feed.title)
      FeedEntry.add_entries(feed_app, feed.entries)
      flag = false
      if !akid.fav.blank?
        begin
          a = Nestful.get feed_app.fav
          flag = true
        rescue
          flag = false
        end
      end
      feed_app.update_attributes(is_pending: "done", last_processed: Time.now, rss_last_modified_at: feed.last_modified, favicon: flag ? feed_app.fav : nil)
    end
  end
  
  #PRIVATE
  private
  
end