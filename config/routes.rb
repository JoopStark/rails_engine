Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        get :find, on: :collection
        resources :items, only: :index
      end

      resources :items, except: :new do
        get :find_all, on: :collection
      end
      get "/items/:item_id/merchant", to: 'merchants#show'
      
      # namespace :merchants do
      #   resources :search, only: :show
      # end
      
      # namespace :items do
      #   resources :search, only: :index
      # end
    end
  end
end
