class CollectVideosJob < ApplicationJob
  include YoutubeApiHelper

  def perform(source_id)
    # Querys a specific youtube channel for Smash Ultimate videos
    source = Source.find(source_id)
    channel_id = source.channel_id
    last_video_date = last_source_video_date(source_id)
    service = youtube_service
    part = 'snippet, id'

    items = service.fetch_all do |token|
      service.list_searches(part,
                            q: 'ssbu|ultimate',
                            channel_id: channel_id,
                            published_after: last_video_date,
                            max_results: 50,
                            type: 'video',
                            page_token: token)
    end
    total_videos_created = process_items(items, source_id)
    source.update(last_collected: DateTime.current)
    puts "Collected #{total_videos_created} new videos from #{source.name}"
  end

  def process_items(items, source_id)
    # Takes items from API and creates videos from them
    videos_created = 0
    items.each do |item|
      title = item.snippet&.title
      published_at = item.snippet&.published_at
      description = item.snippet&.description
      video_id = item.id&.video_id

      # Return if info missing
      next if !title || !published_at || !description || !video_id

      # Return if video already in system
      video = Video.find_by(video_id: video_id)
      next if video

      # Create the video
      video = Video.new(
        video_id: video_id,
        title: title,
        upload_date: published_at,
        source_id: source_id
      )
      if video.save
        video.create_description(value: description)
        videos_created += 1
      end
    end
    videos_created
  end

  def last_source_video_date(source_id)
    source = Source.find(source_id)
    last_video_date = source.videos.order(:upload_date).last&.upload_date&.rfc3339&.to_s
    smash_release_date = DateTime.parse('December 8, 2018').rfc3339.to_s
    last_video_date || smash_release_date
  end
end
