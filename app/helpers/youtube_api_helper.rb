require 'google/apis/youtube_v3'

module YoutubeApiHelper
  def youtube_service
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = ENV['YOUTUBE_DATA_API_KEY']
    service.client_options.application_name = ENV['YOUTUBE_APPLICATION_NAME']
    service.authorization = nil

    service
  end
end
