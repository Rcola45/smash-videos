class VideosController < ApplicationController
  protect_from_forgery except: [:youtube_callback]

  def index
    @videos = Video.ssbu.preload(:source, :description, match: [:match_players, :players, :characters]).last(10)
  end

  def youtube_callback
    if params['hub.challenge']
      # For subscribing to video
      if params['hub.mode'].in? ['subscribe', 'unsubscribe']
        handle_subscription
      else
        puts "Unknown mode: #{params['hub.mode']}"
      end
    else
      # See example rss here: https://developers.google.com/youtube/v3/guides/push_notifications
      raw_body = request.body.read
      rss = Feedjira.parse(raw_body)
      if rss
        parse_xml_videos rss
      else
        puts 'Could not parse rss feed'
      end
      head 204, content_type: 'text/html'
    end
  end

  private

  def parse_xml_videos(rss)
    rss.entries.each do |rss_entry|
      video_elements = extract_video_elements(rss_entry)
      source = Source.find_by(channel_id: video_elements[:channel_id])
      if source
        video = Video.find_or_create_by(video_id: video_elements[:video_id]) do |v|
          v.title = video_elements[:title]
          v.url = video_elements[:url]
          v.upload_date = video_elements[:upload_date]
          v.source = source
          v.view_count = 0
        end
      else
        puts "Source not found for channel id <#{video_elements[:channel_id]}>"
      end
    end
  end

  def handle_subscription
    channel_id = params['hub.topic'].split('?')[1].split('=')[1]
    if Source.find_by(channel_id: channel_id)
      puts "#{params['hub.mode']}ing with channel id <#{channel_id}>"
      render plain: params['hub.challenge']
    else
      puts "Channel with id <#{channel_id}> is not in the database currently"
      head 204, content_type: 'text/html'
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
