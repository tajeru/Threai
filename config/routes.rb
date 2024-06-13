Rails.application.routes.draw do
  get 'about/top'
  get "/" => 'home#top'

  get 'posts/index' => 'posts#index'
  post 'posts/new' => 'posts#new'
  delete 'posts/:id' => 'posts#destroy'
  post 'posts/reply' => 'posts#reply'
  post 'posts/create' => 'posts#create'


  get "users/new" => "users#new"
  post "users/create" => "users#create"
  get "users/login_form" => "users#login_form"
  post "users/login" => "users#login"
  get "users/logout" => "users#logout"

  get "question/top" => "question#top"
  post "question/ask" => "question#ask"

  get "about/top" => "about#top"


  get 'revelum/index' => 'revelum#index'
  post 'revelum/create' => 'revelum#create'


end
