class AddVideoIdAndChannelId < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :video_id, :string, null: false
    add_column :sources, :channel_id, :string
  end
end
