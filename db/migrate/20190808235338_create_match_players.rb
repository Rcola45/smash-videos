class CreateMatchPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :match_players do |t|
      t.references :player
      t.references :match
      t.integer :team_id
    end

    create_join_table :match_players, :characters
  end
end
