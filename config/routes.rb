Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
}

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/customers#guest_sign_in'
  end

  namespace :admin do
    get "search_rest" => "rests#search_rest"
    get "search" => "searches#search"
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :rests, only: [:index, :show, :destroy] do
      resources :rest_comments, only: [:destroy]
    end
  end

  #public
  root :to => "public/homes#top"
    get "search_rest" => "public/rests#search_rest"
    get "rests/favorites" => "public/favorites#index"
  scope module: :public do
    get "search" => "searches#search"
    get 'homes/about' => "public/homes#about"
    get "customers/:id/withdrawal_confirm" => "customers#withdrawal_confirm", as: "withdrawal_confirm"
    patch "customers/:id/withdrawal" => "customers#withdrawal",as: "withdrawal"
    resources :rests, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :rest_comments, only: [:create, :destroy, :index]
    end
    resources :customers, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
end

