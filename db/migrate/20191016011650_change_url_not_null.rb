class ChangeUrlNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :videos, :url, :string, null: true
  end
end
