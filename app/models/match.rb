class Match < ApplicationRecord
  belongs_to :tournament, optional: true
  has_many :match_players, dependent: :destroy
  has_many :players, through: :match_players
  has_many :characters, through: :match_players
  belongs_to :match_type
  belongs_to :video
end
