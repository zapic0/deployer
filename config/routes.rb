resources :projects do
  resources :deploys, :controller => 'deploys'

  resources :deploys do
    member do
      get 'send_start'
      get 'send_successful_end'
      get 'send_rollback'
      get 'delete'
    end
  end
end
