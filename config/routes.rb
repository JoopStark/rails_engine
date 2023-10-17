Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: :index
      end
      get "/items/:item_id/merchant", to: 'merchants#show'
      namespace :merchants do
        resources :search, only: :show
      end
      namespace :items do
        resources :search, only: :index
      end
    end
  end
end
