MyStore::Application.routes.draw do

  resources :items do
    get :upvote, on: :member
    get :expensive, on: :collection
  end

  root to: redirect("items_path")

end
