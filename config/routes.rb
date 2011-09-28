Www::Application.routes.draw do
  resources :test_models

  resources :pages
  match '/publish/:id' => "pages#publish", :as => "publish"
  match '/unpublish/:id' => "pages#unpublish", :as => "unpublish"
end
