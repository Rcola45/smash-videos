class VideosController < ApplicationController
  def index
    @text = 'Main Video Page'
  end

  def youtube_collection
    puts params
    render json: { status: 200 }
  end
end
