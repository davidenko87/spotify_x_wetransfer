Rails.application.routes.draw do
  devise_for :users, path: '/', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get     'sign_in',                to: 'devise/sessions#new',      as: :new_user_session
    get     'sign_out',               to: 'devise/sessions#destroy',  as: :destroy_user_session
  end
  get '/sign-up',                     to: 'page#signup',              as: 'signup'

  authenticated :user do
    get '/dashboard',                 to: 'dashboard#show', as: 'dashboard'
    get '/dashboard/playlist_tracks', to: 'dashboard#playlist_info'
    post '/share_playlist',           to: 'dashboard#export_to_transfer'
    post '/share_selected_playlist',  to: 'dashboard#export_selected_playlists'
    post '/share_selected_tracks',    to: 'dashboard#export_selected_tracks'
    get '/dashboard/top_tracks',      to: 'dashboard#top_tracks'
  end

  root 'page#home'
end
