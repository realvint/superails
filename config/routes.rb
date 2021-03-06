Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'static_public#landing_page'
  # get 'static_public/landing_page'
  get 'privacy', to: 'static_public#privacy'
  get 'terms', to: 'static_public#terms'
  resources :users, only: %i[index show]
  resources :questions do
    resources :answers
  end
  resources :topics do
    resources :topic_messages
  end
  resources :products do
    get :export, on: :collection
    post :import, on: :collection
  end
end
