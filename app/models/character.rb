class Character < ApplicationRecord
  has_and_belongs_to_many :games
  has_and_belongs_to_many :match_players
  has_many :matches, through: :match_players
  has_many :videos, through: :matches

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.find_by_name(character_name)
    found = Character.where('lower(name) = ?', character_name.downcase).first
    return found if found

    # Search aliases
    alias_character_id = Alias.where('lower(alt) = ? AND object_type = ?', character_name.downcase, 'Character').first&.object_id
    alias_found = Character.find_by(id: alias_character_id) if alias_character_id
    return alias_found if alias_found

    # Try your best
  end
end
