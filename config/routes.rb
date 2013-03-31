EchoReboot::Application.routes.draw do
  devise_for :users


  scope module: :statements do
    resources :statements, only: [:index]
    resources :questions, except: [:index]
  end

  root to: "static_pages#index"
end
