class VideosController < ApplicationController
  def index
    @text = 'Main Video Page'
  end

  def youtube_callback
    puts params
    render json: { status: 200 }
  end
end
