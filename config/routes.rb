Xegra::Application.routes.draw do
  match 'reproductions/new/:id/:repro_id' =>'reproductions#single_reproduction', :as =>'proba_repro'
  match 'reproductions/new/:id' =>'reproductions#single_reproduction', :as =>'proba'
  
  resources :reproductions

  resources :reproduction_simbols

  scope "/:locale", :constraints => {:locale => /es|gl/} do
    match 'kine/:id/down_cow' => 'kine#get_cow_down', :as => 'down_cow'
    resources :kine

    root :to => 'kine#index'

  end

  root :to => 'kine#index'

end
