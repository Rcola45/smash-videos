class VideoCollectionSchedulerJob < ApplicationJob
  Source.active.find_each do |source|
    # delay = rand(1..60).minutes
    # CollectVideosJob.set(wait: delay).perform_later()
  end
end
