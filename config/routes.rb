Rails.application.routes.draw do
  root 'welcome#home'

  resources :lost_birds, only: [:new, :create, :show] do
    collection do
      get 'search'
    end
  end
end
