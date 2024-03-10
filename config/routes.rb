Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :customers do
        resources :subscriptions, only: [:create]
      end
    end
  end
end
