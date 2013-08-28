Smartbars::Application.routes.draw do
  devise_for :users, controllers: {
      sessions: "sessions",
      passwords: "passwords"
  }
  resources :users

  get "administration/download/:id" => "administration#download"

  match 'api(/:action)(.:format)' => "api"

  match "/demo_app(/:action)" => "demo_app"

  resources :customers do
    resources :smartbars
  end

  resources :smartbars do
    resources :build, controller: :smartbars_wizard
  end

  root :to => 'administration#index'
end
