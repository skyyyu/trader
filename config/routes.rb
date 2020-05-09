Rails.application.routes.draw do

  root 'posts#timeline'
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "users/:id" => "users#show", as: :mypage
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  delete 'posts/:post_id/likes' => 'likes#destroy'
  resources :posts do
    resources :likes, only: [:create]
  end
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

  put 'users/follow/:user_id' => 'users#follow'
  put 'users/unfollow/:user_id' => 'users#unfollow'
  #フォローとフォローを外すアクション

  get 'users/follow_list/:user_id' => 'users#follow_list'
  get 'users/follower_list/:user_id' => 'users#follower_list'
  #フォロー・フォロワーの一覧ページ


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
