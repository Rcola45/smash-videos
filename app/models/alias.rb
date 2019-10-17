class Alias < ApplicationRecord
  belongs_to :object, polymorphic: true

  def add_character_alias(character_id, alt_name)
    character = Character.find_by(id: character_id)
    Alias.find_or_create_by(object: character, alt: alt_name) if character
  end
end
