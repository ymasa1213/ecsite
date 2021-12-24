Rails.application.routes.draw do
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :items, only: [:show, :index]
    get "orders/thanks" => "orders#thanks"
    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        post :confirm
      end
    end
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resource "customers", only: [:show, :edit, :update]
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
  end

  #管理者
  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end
  # コントローラーの記述を変更すると処理を行うように記述

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  #不要なルートはskipオプションでルートを削除
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
