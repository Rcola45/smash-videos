class Source < ApplicationRecord
  has_many :videos

  scope :active, -> { where collection_active: true }

  def feed_channel_url
    "https://www.youtube.com/xml/feeds/videos.xml?channel_id=#{channel_id}"
  end
end
