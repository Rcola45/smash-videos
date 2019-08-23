class Video < ApplicationRecord
  belongs_to :source
  has_one :match
  has_one :match_type, through: :match

  scope :ssbu, -> { where('lower(title) LIKE ? OR lower(title) LIKE ?', '%smash ultimate%', '%ssbu') } #All SSBU videos

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
    parsed_title = regex.parse(title)
    if parsed_title.nil?
      puts "Could not parse title with given regex\nv: #{self.id}\ntr: #{regex.id}"
      return
    end
    (1..match_type.player_count).each do |i|
      player_name = parsed_title["player_#{i}"].strip
      player = Player.find_or_create_by(gamertag: player_name)

      player_characters = parsed_title["player_#{i}_characters"].strip.split(',').map(&:strip)
      match_player = MatchPlayer.find_or_create_by(match_id: match.id, player_id: player.id, team_id: i)
      player_characters.each do |character_name|
        character = Character.find_by_name(character_name)
        match_player.add_character(character) if character
      end
    end
  end
end
