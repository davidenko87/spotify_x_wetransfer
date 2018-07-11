Rails.application.routes.draw do
  devise_for :users, path: '/', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_in',     to: 'devise/sessions#new',     as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  get '/sign-up', as: 'signup', to: 'page#signup'

  authenticated :user do
    get '/dashboard', to: 'dashboard#show', as: 'dashboard'
    get '/dashboard/playlist_tracks', to: 'dashboard#playlist_info'
    post '/share_playlist', to: 'dashboard#export_to_transfer'
  end

  root 'page#home'
end
