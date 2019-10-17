class MatchPlayer < ApplicationRecord
  has_and_belongs_to_many :characters
  belongs_to :player
  belongs_to :match
  has_one :video, through: :match

  default_scope { order(team_id: :asc) }

  def add_character(character)
    characters << character unless characters.include?(character)
  end
end
