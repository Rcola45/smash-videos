class Source < ApplicationRecord
  has_many :videos
  has_many :title_regexes

  scope :active, -> { where collection_active: true }

  def feed_url
    "https://www.youtube.com/xml/feeds/videos.xml?channel_id=#{channel_id}"
  end

  def url
    "https://www.youtube.com/channel/#{channel_id}"
  end
end
