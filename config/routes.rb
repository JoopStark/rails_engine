Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: :index
      end
      resources :items do
        resources :merchants, only: :index
      end
      get '/merchants/single_search', to: 'merchants#single_search'
      get '/items/search', to: 'items#search'
    end
  end
end
