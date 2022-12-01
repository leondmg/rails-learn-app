Rails.application.routes.draw do
  root 'pages#index'
  
  resources :questions do
    resources :answers, except: [:new, :show]
  end
end
