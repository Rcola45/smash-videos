class ApplicationController < ActionController::Base
  private

  def set_games
    @ssbu = Game.find_by(title: 'Super Smash Bros. Ultimate')
  end
end
