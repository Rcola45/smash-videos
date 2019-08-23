class FixVideoMatches < ActiveRecord::Migration[5.2]
  def change
    remove_reference :videos, :match
    add_reference :matches, :video
  end
end
