Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :images, only: [:create, :show] do
    member do
      get "formats/:format", to: "images/formats#show"
    end
  end
end
