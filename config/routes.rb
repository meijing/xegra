Xegra::Application.routes.draw do
  scope "/:locale", :constraints => {:locale => /es|gl/} do
    resources :kine

    root :to => 'kine#index'

  end

  root :to => 'kine#index'

end
