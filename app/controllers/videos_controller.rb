class VideosController < ApplicationController
  protect_from_forgery except: [:youtube_callback]

  def index
    @text = 'Main Video Page'
  end

  def youtube_callback
    if params['hub.challenge']
      # For subscribing to video
      render plain: params['hub.challenge']
    else
      # See example rss here: https://developers.google.com/youtube/v3/guides/push_notifications
      raw_body = request.body.read
      rss = Feedjira.parse(raw_body)
      if rss
        parse_xml_videos rss
      else
        puts 'No video info found in xml'
      end
      head 204, content_type: "text/html"
    end
  end

  private

  def parse_xml_videos(rss)
    rss.entries.each do |rss_entry|
      video = extract_video_elements(rss_entry)
      source = Source.find_by(channel_id: video[:channel_id])
      if source
        Video.find_or_create_by(video_id: video[:video_id]) do |v|
          v.title = video[:title]
          v.url = video[:url]
          v.upload_date = video[:upload_date]
          v.source = source
          v.view_count = 0
        end
      else
        puts "Source not found for channel id <#{video[:channel_id]}>"
      end
    end
  end

  def extract_video_elements(video)
    elements = {}
    elements[:title] = video.title
    elements[:url] = video.url
    elements[:upload_date] = video.published.to_date
    elements[:video_id] = video.youtube_video_id
    elements[:channel_id] = video.youtube_channel_id
    # elements[:description] = video.content
    elements
  end
end
