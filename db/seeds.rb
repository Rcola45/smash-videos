# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Source.find_or_create_by(name: 'VGBootCamp', url: 'https://www.youtube.com/channel/UCj1J3QuIftjOq9iv_rr7Egw', channel_id: 'UCj1J3QuIftjOq9iv_rr7Egw')

source = Source.find_or_create_by(name: '2GGaming', url: 'https://www.youtube.com/channel/UClIuCiBN-UIsTZb0WlhRo0Q', channel_id: 'UClIuCiBN-UIsTZb0WlhRo0Q')
# Regex for 2GGaming(incomplete): /(?<tournament>(\w*\s\d+(\.\d+)?\s-?|^(.*?)-))(?<player_one>[^(]+)\((?<player_one_characters>[^)]+)\)\s+(?<vs>(Vs\.?|versus))\s+(?<player_two>[^(]+)\((?<player_two_characters>[^)]+)\)(?<tournament_info>.*$)/i 

Video.find_or_create_by(title: 'WNF 2.7 YMCA (Donkey Kong) vs Paper (Mr. Game and Watch) - Losers Quarters - Smash Ultimate',
                        url: 'https://www.youtube.com/watch?v=R1jzLWZ_1ZM',
                        upload_date: 'Jun 22, 2019'.to_date,
                        view_count: 1876,
                        video_id: 'R1jzLWZ_1ZM',
                        source: source)
