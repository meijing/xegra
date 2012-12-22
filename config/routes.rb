Xegra::Application.routes.draw do
  

  devise_for :users

  match 'reproductions/new/:id/:repro_id/:simbol_id/:month' =>'reproductions#single_reproduction', :as =>'proba_repro'
  match 'reproductions/new/:id' =>'reproductions#single_reproduction', :as =>'proba'
  
  resources :reproductions

  resources :reproduction_simbols
  scope "/:locale", :constraints => {:locale => /es|gl/} do

    match 'kine/is_not_pregnant' =>'kine#set_is_not_pregnant', :as =>'is_not_pregnant'
    match 'kine/is_pregnant' =>'kine#set_is_pregnant', :as =>'is_pregnant'
    match 'kine/notifications' =>'kine#notifications', :as =>'notifications'
    match 'lactations/2/edit/:cow_id/:id' => 'lactations#edit', :as => 'update_lactation'
    match 'lactations/new/:cow_id' => 'lactations#new', :as=>'create_new_lactation'

    resources :lactations
   
    resources :facturation_milks
    resources :kine
    
    root :to => 'kine#index'

  end

  root :to => 'kine#index'

end
