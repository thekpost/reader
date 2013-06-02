class TagEntry < ActiveRecord::Base
  
  attr_accessible :app_key_id, :tag_id
  
  belongs_to :app_key
  belongs_to :tag
  
  def self.import(akid, tgid)
    a = TagEntry.where(app_key_id: akid, tag_id: tgid).first
    if a.blank?
      TagEntry.create(app_key_id: akid, tag_id: tgid)
    end
  end  
  
end
