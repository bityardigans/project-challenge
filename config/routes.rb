Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :dogs
  root to: "dogs#index"
  match '/dogs/like', to: 'dogs#like', :as => 'like', via: :post
end
