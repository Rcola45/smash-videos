module ParserConcern
  extend ActiveSupport::Concern

  def verify_parse_captures(attrs)
    valid = true
    required_group_names = [
      'player_1',
      'player_1_characters',
      'player_2',
      'player_2_characters'
    ]
    required_group_names.each do |name|
      group_item = attrs[name]
      valid = false unless group_item && !group_item.blank?
    end
    valid
  end
end
