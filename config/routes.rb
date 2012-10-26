Xegra::Application.routes.draw do
  resources :reproductions

  resources :reproduction_simbols

  scope "/:locale", :constraints => {:locale => /es|gl/} do
    match 'kine/:id/down_cow' => 'kine#get_cow_down', :as => 'down_cow'
    resources :kine

    root :to => 'kine#index'

  end

  root :to => 'kine#index'

end
