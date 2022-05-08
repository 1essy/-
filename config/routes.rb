Rails.application.routes.draw do


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
}

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :rests, only: [:index, :show, :destroy] do
      resources :rest_comments, only: [:destroy]
    end
  end
  
  
  #public
  root :to => "public/homes#top"
  scope module: :public do
    get 'homes/about' => "public/homes#about"
    get "customers/:id/withdraw_confirm" => "customers#withdraw_confirm", as: "withdraw_confirm"
    patch "customers/:id/withdraw" => "customers#withdraw",as: "withdraw"
    resources :rests, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :rest_comments, only: [:create, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
