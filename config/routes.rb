Rails.application.routes.draw do

  post :incoming, to: 'incoming#create'

 resources :topics do
   resources :bookmarks
 end

  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
