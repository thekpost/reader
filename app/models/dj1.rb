class Dj1 < Struct.new(:akid)
  
  #WHEN A FEED IS FIRST ADDED
  
  def perform
    feed_app = AppKey.find(akid)
    feed = Feedzirra::Feed.fetch_and_parse(feed_app.app_url)
    if feed.class.to_s != "Fixnum"
      feed_app.update_attributes(entity_name: feed.title)
      FeedEntry.add_entries(feed_app, feed.entries)
      feed_app.update_attributes(is_pending: "done", last_processed: Time.now, rss_last_modified_at: feed.last_modified)
    end
  end
  
  #PRIVATE
  private
  
end

undefined method `title' for 0:Fixnum\n/app/app/models/dj1.rb:8:in `perform'\n/app/vendor/bundle/ruby/1.9.1/gems/delayed_job-3.0.5/lib/delayed/backend/base.rb:95:in `block in invoke_job'\n/app/vendor/bundle/ruby/1.9.1/gems/delayed_job-3.0.5/lib/delayed/lifecycle.rb:60:in `call'\n/app/vendor/bundle/ruby/1.9.1/gems/delayed_job-3.0.5/lib/delayed/lifecycle.rb:6