class MatchType < ApplicationRecord
  has_many :matches
  has_many :title_regexes
end
