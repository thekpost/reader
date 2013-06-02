class Dj2 < Struct.new(uid)
  
  #NIGHTLY REFRESH ALL FEEDS
  
  def perform
    user = User.find(uid)
    user.app_keys.each do |feed_app|
      FeedEntry.update_from_feed(feed_app)
    end
  end
  
  #PRIVATE
  private
  
end