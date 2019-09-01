module TextCleanerConcern
  extend ActiveSupport::Concern
  def clean_whitespace(string)
    string.strip
  end

  def extract_sponsor(player_string)
    # Return: [name, sponsor]
    player_string.split('|').map(&:strip).reverse
  end
end
