class UploadDateToDateTime < ActiveRecord::Migration[5.2]
  def change
    change_column :videos, :upload_date, :datetime
  end
end
