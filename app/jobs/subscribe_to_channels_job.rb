require 'net/http'

class SubscribeToChannelsJob < ApplicationJob
  def perform
    Source.active.each do |source|
      subscribe source.feed_channel_url
    end
  end

  def subscribe(feed_channel_url)
    params = {
      'hub.mode': 'subscribe',
      'hub.topic': feed_channel_url,
      'hub.callback': 'https://smash-videos.herokuapp.com/youtube_callback',
      'hub.lease_seconds': '2592000'
    }

    subscription_hub_url = 'https://pubsubhubbub.appspot.com/subscribe'
    request = Net::HTTP.post_form(URI.parse(subscription_hub_url), params)
    if request.code == '202'
      puts "Successfully subscribed to channel #{feed_channel_url}"
    else
      puts "Bad SubscriptionRequest: #{request.body}"
    end
  end
end
