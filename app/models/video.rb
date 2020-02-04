class Video < ApplicationRecord
  belongs_to :source
  has_one :description, dependent: :destroy
  has_one :match, dependent: :destroy
  has_one :match_type, through: :match
  has_many :match_players, through: :match
  has_many :players, through: :match
  has_many :characters, through: :match

  scope :ssbu, -> { where('lower(title) LIKE ? OR lower(title) LIKE ? OR lower(title) LIKE ?', '%smash ultimate%', '%ssbu%', '%bros ultimate%') } #All SSBU videos

  def url
    read_attribute(:url) || "https://www.youtube.com/watch?v=#{video_id}"
  end

  def embedded_url
    "https://www.youtube.com/embed/#{video_id}"
  end

  def share_url
    "https://youtu.be/#{video_id}"
  end

  def iframe
    "<iframe width='560' height='315' src='#{embedded_url}' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>"
  end

  def parse_title
    unless match
      self.match = Match.create(video_id: self.id, match_type: MatchType.find_by(name: 'Singles'))
      save
    end

    regex = TitleRegex.find_by(source: source, match_type: match_type)
    if regex.nil?
      puts "Could not find matching title regex\ns:#{source.id}\nmt: #{match_type.id}"
      return
    end
    regex.parse(id)
  end
end
