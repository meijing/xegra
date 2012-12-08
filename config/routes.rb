Xegra::Application.routes.draw do
  
  match 'reproductions/new/:id/:repro_id/:simbol_id/:month' =>'reproductions#single_reproduction', :as =>'proba_repro'
  match 'reproductions/new/:id' =>'reproductions#single_reproduction', :as =>'proba'
  
  resources :reproductions

  resources :reproduction_simbols
  scope "/:locale", :constraints => {:locale => /es|gl/} do

    match 'lactations/2/edit/:cow_id/:id' => 'lactations#edit', :as => 'update_lactation'
    match 'lactations/new/:cow_id' => 'lactations#new', :as=>'create_new_lactation'
    resources :lactations
    
  
    resources :kine

    root :to => 'kine#index'

  end

  root :to => 'kine#index'

end
