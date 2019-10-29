class Alias < ApplicationRecord
  belongs_to :object, polymorphic: true

  scope :unknowns, -> { where(object_type: 'MatchPlayer') }

  def self.add_character_alias(character_id, alt_name)
    character = Character.find_by(id: character_id)
    if character
      Alias.find_or_create_by(object: character, alt: alt_name)
      bad_alts = Alias.where(object_type: 'MatchPlayer').where('lower(alt) = ?', alt_name.downcase).each do |a|
        mp = a.object
        mp.characters << character unless mp.characters.include?(character) || mp.nil?
      end
      bad_alts.map(&:destroy)
    else
      puts "Could not find character with ID: #{character_id}"
    end
  end
end
