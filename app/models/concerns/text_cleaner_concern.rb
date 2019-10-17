module TextCleanerConcern
  extend ActiveSupport::Concern
  def clean_whitespace(string)
    string.strip
  end

  def extract_sponsor(player_string)
    # Return: [name, sponsor]
    # TODO: Could have multiple sponsors (NRG | RCS | Fatality)
    player_string.split('|').map(&:strip).reverse
  end
end
