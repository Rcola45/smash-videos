class CreateTableAliases < ActiveRecord::Migration[5.2]
  def change
    create_table :aliases do |t|
      t.string :alt
      t.string :object_type
      t.bigint :object_id
    end
  end
end
