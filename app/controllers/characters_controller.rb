class CharactersController < ApplicationController
  before_action :set_character, only: [:show]
  before_action :set_games
  
  def index
    @characters = @ssbu.characters.order(:name)
  end

  def show
    @videos = @character.videos.last(10)
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end
end
