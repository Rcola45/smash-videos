class TitleRegex < ApplicationRecord
  include TextCleanerConcern
  include ParserConcern
  belongs_to :source
  belongs_to :match_type
  belongs_to :game

  def regex_string
    # Convert url_regex string to regex object
    Regexp.new(super, Regexp::IGNORECASE)
  end

  def parse(video_id)
    video = Video.find_by(id: video_id)
    return if video.nil?

    match = video.match
    string = video.title
    parsed_string = string.match(regex)
    # parsed_string ||= match_basic(string)
    if parsed_string.nil?
      puts "Could not parse string for tr:<#{id}> and vid: #{video_id}"
      return
    end
    attrs = parsed_string.named_captures
    unless verify_parse_captures(attrs)
      puts "Could not verify captures for tr:<#{id}> and vid: #{video_id}"
      return
    end

    [1, 2].each do |index|
      player_name = clean_whitespace(attrs["player_#{index}"])
      character_list = attrs["player_#{index}_characters"].split(',').map(&:strip)

      player_name, sponsor_name = extract_sponsor(player_name)
      player = Player.find_or_create_by(gamertag: player_name)
      player.update(sponsor: sponsor_name) if sponsor_name
      match_player = MatchPlayer.find_or_create_by(player: player, match: match, team_id: index)
      current_character_ids = match_player.characters.ids
      characters = []
      unknown_characters = []
      character_list.each do |character_name|
        character = Character.find_by_name(character_name)
        if character
          characters << character if current_character_ids.exclude?(character.id)
        else
          unknown_characters << character_name
        end
      end
      match_player.characters << characters
      unknown_characters.each do |unknown_char_name|
        Alias.find_or_create_by(object_type: 'MatchPlayer', object_id: match_player.id, alt: unknown_char_name)
      end
    end
  end
end
