class Dj2 < Struct.new()
  
  #NIGHTLY REFRESH ALL FEEDS
  
  def perform
    AppKey.all.each do |feed_app|
      FeedEntry.update_from_feed(feed_app)
    end
  end
  
  #PRIVATE
  private
  
end