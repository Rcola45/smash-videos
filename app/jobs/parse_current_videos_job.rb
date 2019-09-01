class ParseCurrentVideosJob < ApplicationJob
  # Create new players/tournaments/matches from current videos in db
  def perform
    Video.ssbu.find_each do |video|
      # Only parse videos with no match
      if video.match.nil?
        source_id = video.source.id
        video_id = video.id
        match_type = MatchType.find_by(name: 'Singles')
        match = Match.create(match_type_id: match_type.id, video_id: video_id)
        title_regexes = video.source.title_regexes
        if title_regexes.any? && match
          title_regexes.each { |tr| tr.parse(video.id) }
        else
          puts "No TR for s:<#{source_id}>"
        end
      end
    end
  end
end
