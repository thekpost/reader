class Tag < ActiveRecord::Base
  attr_accessible :name, :sort_id, :sort_order, :user_id
  belongs_to :user
  has_many :tag_entries
  has_many :app_keys, through: :tag_entries
  
  def self.import(u, a_json)
    a_json.each do |t|
      if u.tags.where(name: t[0]).first.blank?
        Tag.create(user_id: u.id, name: t[0], sort_id: t[1])
      end
    end
  end
  
end
