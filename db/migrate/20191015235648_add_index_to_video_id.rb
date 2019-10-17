class AddIndexToVideoId < ActiveRecord::Migration[5.2]
  def change
    add_index :videos, :video_id
  end
end
