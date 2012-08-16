Metin::Application.routes.draw do
  root to: "stories#index"
  
  match "/company" => "identities#show", as: "company"
  
  match "/login" => "sessions#new", as: "login"
  match "/logout" => "sessions#destroy", as: "logout"
  
  resources :stories
  resources :employees do
    collection do 
      post :sort 
      get :sort
    end
  end
  resource :identity
  resource :session
  
  match ':controller(/:action(/:id))(.:format)'
end
