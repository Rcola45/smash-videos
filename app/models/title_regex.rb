class TitleRegex < ApplicationRecord
  include TextCleanerConcern
  belongs_to :source
  belongs_to :match_type
  belongs_to :game

  def regex
    # Convert url_regex string to regex object
    Regexp.new regex_string
  end

  def parse(video_id)
    video = Video.find_by(id: video_id)
    return if video.nil?

    match = video.match
    string = video.title
    parsed_string = string.match(regex)
    # parsed_string ||= match_basic(string)
    if parsed_string.nil?
      puts "Could not parse string for tr:<#{id}>"
      return
    end
    attrs = parsed_string.named_captures

    [1, 2].each do |index|
      player_name = attrs["player_#{index}"]
      character_list = attrs["player_#{index}_characters"]
      if player_name
        player_name = clean_whitespace(player_name)
        player_name, sponsor_name = extract_sponsor(player_name)
        # TODO: Sponsor would come first
        player = Player.find_or_create_by(gamertag: player_name)
        player.update(sponsor: sponsor_name) if sponsor_name
        match_player = MatchPlayer.find_or_create_by(player: player, match: match, team_id: index)
        if character_list
          character_list = character_list.split(',').map(&:strip)
          characters = []
          unknown_characters = []
          character_list.each do |character_name|
            character = Character.find_by_name(character_name)
            if character
              characters << character
            else
              unknown_characters << character_name
            end
          end
          match_player.characters << characters
          unknown_characters.each do |unknown_char_name|
            Alias.find_or_create_by(object_type: 'UnknownCharacter', object_id: match_player.id, alt: unknown_char_name)
          end
        else
          puts "Could not find player #{index} characters for v:<#{video_id}>"
        end
      else
        puts "Could not find player #{index} name for v:<#{video_id}>"
      end
    end
  end
end
