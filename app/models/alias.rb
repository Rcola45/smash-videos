class Alias < ApplicationRecord
  belongs_to :object, polymorphic: true
end
