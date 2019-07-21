class VideosController < ApplicationController
  protect_from_forgery except: [:youtube_callback]

  def index
    @text = 'Main Video Page'
  end

  def youtube_callback
    if params['hub.challenge']
      render plain: params['hub.challenge']
    else
      puts 'New Video'
      puts params
      puts request.body
    end
  end
end
