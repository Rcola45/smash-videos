class AddUniqIndexToMatchPlayers < ActiveRecord::Migration[5.2]
  def change
    add_index :characters_match_players, [:match_player_id, :character_id], unique: true, name: 'index_unique_character_id_and_match_player_id'
  end
end
