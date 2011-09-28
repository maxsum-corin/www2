Www::Application.routes.draw do
  resources :pages
  match '/publish/:id' => "pages#publish", :as => "publish"
end
