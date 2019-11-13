class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD'], only: :admin

  def admin
    @bad_names = Alias.where(object_type: 'MatchPlayer').group(:alt).count
  end
  
  private

  def set_games
    @ssbu = Game.find_by(title: 'Super Smash Bros. Ultimate')
  end
end
