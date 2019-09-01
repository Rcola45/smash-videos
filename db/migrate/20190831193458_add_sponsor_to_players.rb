class AddSponsorToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :sponsor, :string
  end
end
