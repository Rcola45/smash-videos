class CreateDescriptionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptions do |t|
      t.text :value
      t.belongs_to :video
    end
  end
end
