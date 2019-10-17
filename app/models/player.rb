class Player < ApplicationRecord
  has_many :match_players

  def name_with_sponsor
    (sponsor ? "#{sponsor} | " : '') + gamertag
  end
end
