Rails.application.routes.draw do

# module（scope module）は「Controller#Action」のみカスタマイズしたい場合に使用します。
  scope module: :public do
    root to: 'homes#top'
    get 'customers' => 'customers#show'
    patch '/customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    get 'customers/confirm' => 'customers#confirm'
    resource :customers, only: [:edit, :update]
    resources :coordinates, only: [:index, :show]
  end

  # namespaceは「URI Pattern」と「Controller#Action」の2つを同時にカスタマイズしたい場合に使用します。
  namespace :admin do
    get '/' => 'customers#index'
    get 'coordinates/rank' => 'coordinates#rank'
    resources :coordinates, only: [:new, :create]
    resources :tags, only: [:index, :create]
    resources :customers, only: [:edit, :update]
  end


  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip:[:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
