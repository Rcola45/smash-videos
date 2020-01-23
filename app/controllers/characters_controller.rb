class CharactersController < ApplicationController
  before_action :set_character, only: [:show]
  before_action :set_games

  # Weird workaround for calling post: :index from js
  skip_before_action :verify_authenticity_token, only: :index
  before_action :verify_authenticity_token, if: -> { request.format.json? }
  
  def index
    @characters = @ssbu.characters.search(params[:search]).order(:name)
    # TODO: Show 'no characters' message if search result returns nothing
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @videos = @character.videos.last(10)
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end
end
