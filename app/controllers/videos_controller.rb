class VideosController < ApplicationController
  def index
    @text = 'Main Video Page'
  end

  def youtube_collection
    render json: { status: 200 }
  end
end
