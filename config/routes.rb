Rails.application.routes.draw do
  root 'bank_accounts#index'
  devise_for :users
  resources :bank_accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
