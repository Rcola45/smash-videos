class CreateTitleRegex < ActiveRecord::Migration[5.2]
  def change
    create_table :match_types do |t|
      t.string :name
      t.integer :player_count, default: 2
      t.integer :team_count, default: 2
    end

    add_reference :matches, :match_type

    create_table :title_regexes do |t|
      t.string :regex_string
      t.references :game
      t.references :match_type
      t.references :source
    end
  end
end
