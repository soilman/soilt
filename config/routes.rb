Rails.application.routes.draw do
  
  devise_for :users

  root 'manifest_reports#index'
  get '/search' => 'trucks#search', as: :searches

  resources :companies do 
    resources :trucks, only: [:show]
  end

  get '/trucks/new' => 'trucks#new', as: :new_truck
  get '/trucks/:id/edit' => 'trucks#edit', as: :edit_truck
  post '/trucks' => 'trucks#create', as: :trucks
  patch 'trucks/:id' => 'trucks#update', as: :update_truck
  get '/users/:user_id/manifest_reports/:id/edit' => 'manifest_reports#edit', as: :edit_user_manifest_report
  patch '/users/:user_id/manifest_reports/:id' => 'manifest_reports#update', as: :update_user_manifest_report 

  # resources :manifest_reports do 
  #   get :autocomplete_truck_plate, on: :collection
  # end  

  get '/manifest_reports/autocomplete_truck_plate' => 'manifest_reports#autocomplete_truck_plate', as: :autocomplete_truck_plate_manifest_reports
  get 'manifest_reports/autocomplete_facility_name' => 'manifest_reports#autocomplete_facility_name', as: :autocomplete_facility_name_manifest_reports
  get 'manifest_reports/autocomplete_project_name' => 'manifest_reports#autocomplete_project_name', as: :autocomplete_project_name_manifest_reports

  get 'manifest_reports/export' => 'manifest_reports#export', as: :export_manifest_report
  post 'manifest_reports/export' => 'manifest_reports#export', as: :load_manifest_report

  resources :users do 
    resources :manifest_reports, only: [:new, :create, :show]
  end

  resources :projects, only: [:new, :edit, :create]
  resources :facilities, only: [:new, :edit, :create]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
