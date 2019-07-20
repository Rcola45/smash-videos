class VideosController < ApplicationController
  def index
    @text = 'Main Video Page'
  end

  def youtube_callback
    render plain: params['hub.challenge']
  end
end
