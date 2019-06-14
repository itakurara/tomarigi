Rails.application.routes.draw do
  resources :lost_birds, only: [:new, :create]
end
