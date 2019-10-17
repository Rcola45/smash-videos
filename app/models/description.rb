class Description < ApplicationRecord
  belongs_to :video

  def to_s
    value || ''
  end
end
