class Dj1 < Struct.new(:akid, :first_time)
    
  def perform
    ak = AppKey.find(akid)
    feed_entries = nil
    feed = Feedzirra::Feed.fetch_and_parse(ak.app_url)
    if !feed.blank?
      if feed.class.to_s != "Fixnum"
        #if first_time
          ak.update_attributes(entity_name: feed.title, html_url: feed.url)
          feed_entries = feed.entries
        #else
          #updated_feed = Feedzirra::Feed.update(feed)
          #if !updated_feed.blank?
            #if updated_feed.class.to_s != "Fixnum"
              #if !updated_feed.first.blank?
                #if updated_feed.updated?
                  #feed_entries = updated_feed.new_entries
                #end
              #end
            #end
          #end
        #end
        if !feed_entries.blank?
          FeedEntry.add_entries(ak, feed_entries)
        end
        ak.update_attributes(is_pending: "done", last_processed: Time.now, rss_last_modified_at: feed.last_modified)
      end
    end
    #flag = false
    #if !ak.fav.blank?
      #begin
      #a = Nestful.get ak.fav
        #flag = true
      #rescue
        #flag = false
      #end
    #end
  end
  
end