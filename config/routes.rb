Rails.application.routes.draw do
  # Définir la route root ici
  root 'products#index'
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener"

  # Routes Devise pour la gestion des utilisateurs avec un contrôleur personnalisé pour les sessions
  devise_for :users, controllers: { sessions: 'custom_sessions' }

  # Routes pour les produits
  resources :products, only: [:index, :show]
  
  # Routes pour le panier et les articles du panier
  resource :cart, only: :show
  resources :cart_items, only: [:create, :destroy, :update]
  
  # Routes pour les commandes
  resources :orders, only: [:new, :create]

  # Routes pour les livres avec une action personnalisée `add_tag`
  resources :books do
    member do
      post :add_tag
    end
  end
end
