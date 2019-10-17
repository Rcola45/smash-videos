class AddLastCollectedToSources < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :last_collected, :datetime
  end
end
