class TitleRegex < ApplicationRecord
  belongs_to :source
  belongs_to :match_type
  belongs_to :game

  def regex
    # Convert url_regex string to regex object
    Regexp.new regex_string
  end

  def parse(string)
    string.match(regex_string)
  end
end
