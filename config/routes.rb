Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :users, only: [:show,:index]
  resources :bands do
    collection do
      delete 'drop-member/:mid' => 'bands#destroy_member'
    end
    member do
      #patch 'update' => 'comments#update'
      get 'add-member' => 'bands#add_member'
      post 'add-member' => 'bands#create_member'
      post 'fan' => 'bands#manage_fan'
    end
  end

  resources :concerts
  resources :comments do
    #patch 'update' => ''
  end

  match "concerts/:id", :via=>:post, :controller=>"concerts", :action=>"confirm"
  match "bands/:id" => 'comments#update', :via=>:patch, :controller=>"comments", :action=>"update"
  match "bands/:id" => 'comments#create', :via=>:post, :controller=>"comments", :action=>"create"

  get 'home/index'
  get 'home' => 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'

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
