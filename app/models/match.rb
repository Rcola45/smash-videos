class Match < ApplicationRecord
  belongs_to :tournament, optional: true
  has_many :match_players, dependent: :destroy
  has_many :players, through: :match_players
  has_many :characters, through: :match_players
  belongs_to :match_type
  belongs_to :video

  def video_player_info
    info_string = ''
    match_players.each_with_index do |match_player, i|
      info_string << match_player.player.name_with_sponsor
      info_string << " (#{match_player.characters.pluck(:name).join(',')})"
      (info_string << ' VS ') if i.zero?
    end
    info_string
  end
end
