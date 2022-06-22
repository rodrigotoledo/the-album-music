Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :records
      resources :artists
    end
  end

  root to: "home#index"
end
