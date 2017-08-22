Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#scrape_first'

  get '/index' => 'application#index'
  post '/index' => 'application#index_post'


end
