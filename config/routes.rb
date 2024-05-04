Rails.application.routes.draw do
  resources :exchange_events, except: %i[new edit update]
  resources :families do
    resources :members, except: %i[index show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
