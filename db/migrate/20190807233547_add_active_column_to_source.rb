class AddActiveColumnToSource < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :collection_active, :boolean, default: true
  end
end
