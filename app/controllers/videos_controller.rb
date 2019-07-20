class VideosController < ApplicationController
  def index
    @text = 'Main Video Page'
  end

  def youtube_callback
    render json: { status: 200, body: params['hub.challenge'] }
  end
end
