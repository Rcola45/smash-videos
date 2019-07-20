class CreateSourceAndVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos, force: true do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.date :upload_date
      t.bigint :view_count
      t.timestamps
    end

    create_table :sources, force: true do |t|
      t.string :name, null: false
      t.string :url
    end
  end
end
