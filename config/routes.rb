Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  get '/latest' => 'photos#index', as: 'photos'
  post '/comments/new/:photo_id' => 'comments#create', as: 'new_comment'
  post '/comments/destroy/:id' => 'comments#destroy', as: 'destroy_comment'


  get '/new_album' => 'albums#new', as: 'new_user_album'
  post '/new_album' => 'albums#create'

  get '/tags/:tag' => 'tags#show', as: 'tag'

  get '/upload' => 'photos#new', as: 'new_user_photo'

  post '/upload' => 'photos#create'
  delete '/:user_id/:id' => 'photos#destroy', as: 'destroy_user_photo'

  get '/:user_id/:slug' => 'photos#show', as: 'user_photo'

  get '/:user_id/a/:slug' => 'albums#show', as: 'user_album'
  delete '/:user_id/a/:slug' => 'albums#destroy', as: 'destroy_user_album'

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  devise_scope :user do
    get '/login' => 'devise/sessions#new', as: 'new_user_session'
    post '/login' => 'devise/sessions#create', as: 'user_session'

    get '/logout' => 'devise/sessions#destroy', as: 'destroy_user_session'

    get '/register' => 'devise/registrations#new', as: 'new_user_registration'
    post '/register' => 'devise/registrations#create', as: 'user_registration'
  end

    resources :users, :path => '', :only => [:show] do
      resources :photos, :path => '', :except => [ :create, :index, :show]
      resources :albums, :path => 'a', :except => [:show]
    end


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
