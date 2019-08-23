# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#######################
# Creating Sources
Source.find_or_create_by(name: 'VGBootCamp', url: 'https://www.youtube.com/channel/UCj1J3QuIftjOq9iv_rr7Egw', channel_id: 'UCj1J3QuIftjOq9iv_rr7Egw')

source = Source.find_or_create_by(name: '2GGaming', url: 'https://www.youtube.com/channel/UClIuCiBN-UIsTZb0WlhRo0Q', channel_id: 'UClIuCiBN-UIsTZb0WlhRo0Q')
# Regex for 2GGaming(incomplete): /(?<tournament>(\w*\s\d+(\.\d+)?\s-?|^(.*?)-))(?<player_1>[^(]+)\((?<player_1_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_2>[^(]+)\((?<player_2_characters>[^)]+)\)(?<tournament_info>.*$)/i 

Video.find_or_create_by(title: 'WNF 2.7 YMCA (Donkey Kong) vs Paper (Mr. Game and Watch) - Losers Quarters - Smash Ultimate',
                        url: 'https://www.youtube.com/watch?v=R1jzLWZ_1ZM',
                        upload_date: 'Jun 22, 2019'.to_date,
                        view_count: 1876,
                        video_id: 'R1jzLWZ_1ZM',
                        source: source)

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
