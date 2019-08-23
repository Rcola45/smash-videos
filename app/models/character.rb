class Character < ApplicationRecord
  has_and_belongs_to_many :games
  has_and_belongs_to_many :match_players

  def self.find_by_name(character_name)
    found = Character.find_by(name: character_name)
    return found if found

    # Search aliases
    alias_character_id = Alias.find_by(alt: character_name, object_type: 'Character').object_id
    alias_found = Character.find_by(id: alias_character_id)
    return alias_found if alias_found

    # Try your best
  end
end
