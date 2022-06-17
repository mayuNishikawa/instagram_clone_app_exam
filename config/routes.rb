Rails.application.routes.draw do

  root 'users#new'

  resources :pictures do 
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
