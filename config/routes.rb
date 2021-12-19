Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
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
