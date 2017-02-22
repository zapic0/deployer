resources :projects do
  resources :deploys, :controller => 'deploys'
end