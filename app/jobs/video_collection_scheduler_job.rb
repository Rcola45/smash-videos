class VideoCollectionSchedulerJob < ApplicationJob
  def perform
    Source.active.each do |source|
      delay = rand(1..60).minutes
      CollectVideosJob.set(wait: delay).perform_later()
    end
  end
end
