class MatchPlayer < ApplicationRecord
  has_and_belongs_to_many :characters
  belongs_to :player
  belongs_to :match
  belongs_to :video, through: :match

  def add_character(character)
    characters << character unless characters.include?(character)
  end
end
