Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#top'
  get '/home/about', to: 'home#about'

  devise_for :users

  # ユーザーが認証されていたらブロック内のroutingにアクセスが可能
  # authenticated :user do
    resources :users, only: %i[show index edit update]
    resources :books, except: %i[new]
  # end
end
