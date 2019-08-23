class SubscribeToChannelsJob < ApplicationJob
  # Create new players/tournaments/matches from current videos in db
  def perform
    Video.ssbu.find_each do |video|
      
    end
  end
end
