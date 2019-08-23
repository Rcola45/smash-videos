class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
    end

    create_table :matches do |t|
    end

    add_reference(:matches, :tournament, foreign_key: true)
    add_reference(:videos, :match, foreign_key: true)
  end
end
