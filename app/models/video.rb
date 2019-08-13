class Video < ApplicationRecord
  belongs_to :source
  belongs_to :match
  has_one :match_type, through: :match

  scope :ssbu, -> { where('lower(title) LIKE ? OR lower(title) LIKE ?', '%smash ultimate%', '%ssbu') } #All SSBU videos

  def parse_title
    if match
      regex = TitleRegex.find_by(source: source, match_type: match_type)
      parsed_title = regex.parse(title)
      players = {}
      (1..match_type.player_count).each do |i|
        player_name = parsed_title["player_#{i}"].strip
        player = Player.find_or_create_by(gamertag: player_name)
        players << player

        player_characters = parsed_title["player_#{i}_characters"].join(',')
        match_player = MatchPlayer.find_or_create_by(match: match, player: player, team_id: i)
        player_characters.each do |character_name|
          character = Character.find_by_name(character_name)
          match_player.add_character(character)
        end
      end
    else
      creat
    end
  end
end
