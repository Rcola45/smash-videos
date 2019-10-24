%w[Singles Doubles FFA].each { |match_type_name| MatchType.find_or_create_by(name: match_type_name) }

# Creating Sources
puts 'Creating sources...'
source_names = [
  %w[VGBootCamp UCj1J3QuIftjOq9iv_rr7Egw true],
  %w[2GGaming UClIuCiBN-UIsTZb0WlhRo0Q true],
  %w[Satellite\ Smash UCqB7d-vcBxxlccHB3oMk6ew false],
  %w[Tourney\ Locator UCuBhMqosgW-ECZjJZ9pv0Dg false],
  %w[Rock\ Paper\ Smashville UCuTWfQUrtBHj3usH4jLVL4A true],
  %w[Beyond\ the\ Summit\ -\ Smash UCKJi-4lbB3EwpLpC82OWFjA false],
  %w[Master\ Hand\ Gaming UC0Ddy9_nH95X9f5ay1vAq3Q false],
  %w[Typo\ House\ Games UCjI60POez1Z6M9XhTdJ7XlQ true]
]
sources = []
source_names.each do |channel_name, channel_id, active_collection|
  sources << Source.find_or_create_by(channel_id: channel_id) do |s|
    s.name = channel_name
    s.url = 'https://www.youtube.com/channel/' + channel_id
    s.collection_active = active_collection || false
  end
end
puts "Created #{sources.size} sources."

# Regex for 2GGaming(incomplete): /(?<tournament>(\w*\s\d+(\.\d+)?\s-?|^(.*?)-))(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)/i 

# Video.find_or_create_by(title: 'WNF 2.7 YMCA (Donkey Kong) vs Paper (Mr. Game and Watch) - Losers Quarters - Smash Ultimate',
#                         url: 'https://www.youtube.com/watch?v=R1jzLWZ_1ZM',
#                         upload_date: 'Jun 22, 2019'.to_date,
#                         view_count: 1876,
#                         video_id: 'R1jzLWZ_1ZM',
#                         source: ggaming)

# Video.find_or_create_by(title: 'WNF 1.9 Mr E (Lucina) vs SweetT (Joker) - Grand Finals - Smash Ultimate',
#                         url: 'https://www.youtube.com/watch?v=_AcO0dtIhQI',
#                         upload_date: 'April 18, 2019'.to_date,
#                         view_count: 965349,
#                         video_id: '_AcO0dtIhQI',
#                         source: ggaming)

# Video.find_or_create_by(title: 'Standoff 2019 - NVR | Elegant (Luigi) Vs. YellowRello (Yoshi) Smash Ultimate Tournament Winners 4',
#                         url: 'https://www.youtube.com/watch?v=Vek-2ifrZ08',
#                         upload_date: 'September 1, 2019'.to_date,
#                         view_count: 4054,
#                         video_id: 'Vek-2ifrZ08',
#                         source: vg)
#######################
# Create the Games
puts 'Creating Games...'
ssbu = Game.find_or_create_by(
  title: 'Super Smash Bros. Ultimate',
  release_date: 'December 7, 2018'.to_date
)
ssbm = Game.find_or_create_by(
  title: 'Super Smash Bros. Melee',
  release_date: 'November 21, 2001'.to_date
)
puts 'Finished creating Games.'

#######################
# Create the Characters
puts 'Creating Characters...'
character_names = [
  'Ness',
  'Zelda',
  'Bowser',
  'Yoshi',
  'Pit',
  'Inkling',
  'Villager',
  'Marth',
  'Young Link',
  'Wii Fit Trainer',
  'Ice Climbers',
  'Captain Falcon',
  'Peach',
  'Ryu',
  'Ike',
  'Jigglypuff',
  'King K. Rool',
  'Sonic',
  'Simon',
  'Zero Suit Samus',
  'Little Mac',
  'Isabelle',
  'Shulk',
  'Lucina',
  'Wario',
  'Ridley',
  'Pokémon Trainer',
  'Lucario',
  'Daisy',
  'Roy',
  'King Dedede',
  'ROB',
  'Falco',
  'Luigi',
  'Pichu',
  'Richter',
  'Lucas',
  'Diddy Kong',
  'Pikachu',
  'Meta Knight',
  'Snake',
  'Ganondorf',
  'Corrin',
  'Mega Man',
  'Bayonetta',
  'Toon Link',
  'Rosalina and Luma',
  'Incineroar',
  'Sheik',
  'Olimar',
  'Pac-Man',
  'Dark Samus',
  'Samus',
  'Wolf',
  'Mr. Game & Watch',
  'Robin',
  'Link',
  'Dark Pit',
  'Cloud',
  'Kirby',
  'Duck Hunt',
  'Ken',
  'Greninja',
  'Donkey Kong',
  'Chrom',
  'Fox',
  'Mewtwo',
  'Bowser Jr.',
  'Dr. Mario',
  'Mario',
  'Palutena',
  'Mii Swordfighter',
  'Mii Brawler',
  'Mii Gunner',
  'Piranha Plant',
  'Joker',
  'Hero',
  'Banjo & Kazooie'
]

character_names.each do |character_name|
  ssbu.characters << Character.find_or_create_by(name: character_name)
end

puts 'Finished creating Characters.'

puts "Creating parsers for #{source_names.size} sources"
game = ssbu
singles = MatchType.find_by(name: 'Singles')
doubles = MatchType.find_by(name: 'Doubles')
sources.each do |s|
  singles_regex = []
  doubles_regex = []
  case s.name
  when 'VGBootcamp'
    singles_regex << '(?<tournament>.*?)-(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)'
  when '2GGaming'
    singles_regex << '(?<tournament>(\w*\s\d+(\.\d+)?\s-?|^(.*?)-))(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)'
  when 'Satellite Smash'
    singles_regex << '(?<tournament>(\w*\s\d+(\.\d+)?\s-?|^(.*?)-))(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\).+?(?<vs>(Vs\.?|versus)).+?(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)'
    #Signas [L] (Wii Fit Trainer) vs. Pandarian (Pokemon Trainer) - Orbitar 79 - Grand Finals
    # Mr. E (Lucina) [L] vs. Yeti (Megaman) - Orbitar 76 - Grand Finals
    # DAMN. (Ken) vs. Pokepen (Kirby) - Orbitar 77 - Winners Finals
  when 'Tourney Locator'
    singles_regex << '(?<tournament>.*?)-(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)'
  when 'Rock Paper Smashville'
    singles_regex << '(?<tournament>.*?)-(?<tournament_info>.*?):(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)'
  when 'Beyond the Summit - Smash'
    singles_regex << '(?<player_1>.+?)(?<vs_player>Vs\.?|versus)(?<player_2>.+?)-(?<tournament_info>.*?):(?<game_mode>.*?)-(?<tournament>.+?)\|(?<player_1_characters>.+?)(?<vs_char>Vs\.?|versus)(?<player_2_characters>.+)$'
  when 'Master Hand Gaming'
    singles_regex << '(?<tournament>.*?)-(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)'
  when 'Typo House Games'
    singles_regex << '(?<tournament>.*?)-(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)'
  end
  singles_regex.each { |r| TitleRegex.find_or_create_by(regex_string: r, source: s, game: game, match_type: singles) }
  doubles_regex.each { |r| TitleRegex.find_or_create_by(regex_string: r, source: s, game: game, match_type: doubles) }
end
puts 'Finished creating parsers.'
