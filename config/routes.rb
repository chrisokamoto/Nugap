NugapSystem::Application.routes.draw do 
  

  resources :statuses

  resources :tipo_analises

  resources :parametro_resultados

  resources :resultados

  resources :parametros

  resources :analises

  resources :amostras

  resources :usuarios

  resources :embalagems

  resources :assinaturas

  resources :produtos

  resources :unidades

  resources :empresas



  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root :to => 'welcome#index'

  # Costum routes
  match '/login' => 'login#index', :via => [:get]
  match '/login' => 'login#login', :via => [:post]
  match '/logout' => 'login#logout', :via => [:get]  

  root :to => 'application#index'
  #root :to => 'welcome#index'

  match '/home' => 'home#index', via: [:get]



  #get 'usuarios/create' => 'usuarios#create', :path => 'usuario/novo'
  #post 'usuarios/create' => 'usuarios#create', :path => 'usuario/novo'
  #get 'usuarios/list' => 'usuarios#list', :path => 'usuario/lista'
  #get 'usuarios/update' => 'usuarios#update', :path => 'usuario/update'
  #get 'amostras/create' => 'amostras#create', :path => 'amostra/novo'
  #post '/usuarios/:id/edit' => 'usuarios#edit', as:  :edit
  #get  'usuarios/update' => 'usuarios#update', :as => :update_usuario_path

  

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
