Xegra::Application.routes.draw do
  

  devise_for :controller_milks

  devise_for :cooperatives

  devise_for :veterinarians

  devise_for :ads

  devise_for :admins, :controllers => { :invitations => 'admins' }

  resources :notifications

  devise_for :users

  match 'reproductions/new/:id/:repro_id/:simbol_id/:month' =>'reproductions#single_reproduction', :as =>'proba_repro'
  match 'reproductions/new/:id' =>'reproductions#single_reproduction', :as =>'proba'
  
  resources :reproductions

  resources :reproduction_simbols
  scope "/:locale", :constraints => {:locale => /es|gl/} do
    match 'kine/remove_pregnant/:cow_id'=>'kine#remove_is_pregnant', :as => 'remove_pregnant'
    match 'kine/notifications/set_is_not_milk/:cow_id'=>'kine#notifications_is_not_milk', :as => 'set_is_not_milk'
    delete '/facturation_milks', :to => 'facturation_milks#destroy'
    resources :reports, only: :index do
      collection do
        get "active_cow"
        get "pregnant_cow"
        get "not_pregnant_cow"
        get "is_milk_cow"
        get "is_not_milk_cow"
        get "total_facturation"
        get "cow_without_born"
      end
    end
    match 'kine/is_not_pregnant' =>'kine#set_is_not_pregnant', :as =>'is_not_pregnant'
    match 'kine/is_pregnant' =>'kine#set_is_pregnant', :as =>'is_pregnant'
    match 'kine/notifications' =>'kine#notifications', :as =>'notifications'
    match 'lactations/2/edit/:cow_id/:id' => 'lactations#edit', :as => 'update_lactation'
    match 'lactations/new/:cow_id' => 'lactations#new', :as=>'create_new_lactation'

    resources :lactations
   
    resources :facturation_milks
    resources :kine
    
    root :to => 'kine#index'

    get "links" => "application#links", :as => "links"

  end

  root :to => 'kine#index'

end
