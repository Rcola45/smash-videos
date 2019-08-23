class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :gamertag
    end

    create_table :characters do |t|
      t.string :name
    end

    create_table :games do |t|
      t.string :title
      t.date :release_date
    end

    create_join_table :characters, :games
  end
end
