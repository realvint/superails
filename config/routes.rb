Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'static_public#landing_page'
  # get 'static_public/landing_page'
  get 'privacy', to: 'static_public#privacy'
  get 'terms', to: 'static_public#terms'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
