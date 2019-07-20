Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match 'youtube_callback', to: 'videos#youtube_callback', via: [:post, :get], defaults: {format: :json}
  root to: 'videos#index'
end
