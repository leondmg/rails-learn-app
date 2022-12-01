Rails.application.routes.draw do
  root 'pages#index'
  
  resources :questions do
    resources :answers, only: [:create, :destroy]
  end
end
