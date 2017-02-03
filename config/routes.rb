Rails.application.routes.draw do
  resources :videos
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :seasons
  resources :goals
  resources :teams
  resources :players
  resources :matches
  resources :presences

  get 'presences/:id/new_match_presence' => 'presences#new_match_presence', as: :new_match_presence
  get 'presences/played/:id/:player_id' => 'presences#played', as: :played
  get 'presences/payed/:id/:player_id' => 'presences#payed', as: :payed
  get 'presences/confirmed/:id/:player_id' => 'presences#confirmed', as: :confirmed
  post 'presences/team_played' => 'presences#team_played', as: :team_played
  post 'presences/manage_goals' => 'presences#manage_goals', as: :manage_goals

  get 'reports/top_strikers' => 'reports#top_strikers'
  get 'reports/top_strikers/:id' => 'reports#top_strikers'
  get 'reports/matches' => 'reports#matches'
  get 'reports/seasons' => 'reports#seasons'
  get 'reports/players' => 'reports#players'
  get 'reports/players/:id' => 'reports#players'
  get 'reports/player/:id/' => 'reports#player', as: :reports_player
  get 'reports/match_detail/:id' => 'reports#match_detail', as: :reports_match_detail
  get 'reports/videos' => 'reports#videos'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'reports#top_strikers'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
