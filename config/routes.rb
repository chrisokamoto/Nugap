NugapSystem::Application.routes.draw do 
  

  resources :orcamentos

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

  resources :servico_orcamentos



  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root :to => 'welcome#index'

  # Costum routes
  match '/login' => 'login#index', :via => [:get]
  match '/login' => 'login#login', :via => [:post]
  match '/logout' => 'login#logout', :via => [:get]  

  #post ':preco_servicos/:update_parametro/:produto/:analise', :controller=>'preco_servicos', :action => 'update_parametro'

  get '/preco_servicos/limpa_preco_servicos', :controller=>'preco_servicos', :action => 'limpa_sessao', :as => 'limpa_preco_servicos_path'
  get '/preco_servicos/:get_parametros_preco/:produto/:analise', :controller=>'preco_servicos', :action => 'get_parametros_preco'
  get '/preco_servicos/:salvar_preco/:produto/:analise/:parametro/:preco', :controller=>'preco_servicos', :action => 'salvar_preco', :parametro => /.+(\/.\%+)*/

  resources :preco_servicos

  get '/orcamentos/get_analises/:produto', :controller=>'orcamentos', :action => 'get_analises'
  get '/orcamentos/get_parametros/:produto/:analise', :controller=>'orcamentos', :action => 'get_parametros'
  get '/orcamentos/get_valor_unitario/:produto/:analise/:parametro', :controller=>'orcamentos', :action => 'get_valor_unitario', :parametro => /.+(\/.\%+)*/
  get '/orcamentos/get_valor_total/:valor_unitario/:qtd_amostra', :controller=>'orcamentos', :action => 'get_valor_total', :valor_unitario => /[^\/]*/
  get '/orcamentos/get_valor_total/:valor_unitario', :controller=>'orcamentos', :action => 'get_valor_total', :valor_unitario => /[^\/]*/
  get '/orcamentos/get_valor_desconto/:bruto/:desconto', :controller=>'orcamentos', :action => 'get_valor_desconto', :bruto => /[^\/]*/, :total_pagar => /[^\/]*/
  get '/orcamentos/get_valor_impostos/:total_pagar', :controller=>'orcamentos', :action => 'get_valor_impostos', :total_pagar => /[^\/]*/
  get '/orcamentos/get_telefone_empresa/:empresa', :controller=>'orcamentos', :action => 'get_telefone_empresa'
  get '/orcamentos/saveVirtualServicoOrcamento/:produto/:analise/:parametro/:valor_unitario/:quantidade/:valor_total/:id/:id_servico', :controller=>'orcamentos', :action => 'saveVirtualServicoOrcamento', :parametro => /.+(\/.\%+)*/, :valor_unitario => /[^\/]*/, :valor_total => /[^\/]*/
  get '/orcamentos/get_total/:id/:has_to_save', :controller=>'orcamentos', :action => 'get_valor_total_orcamento'
  get '/orcamentos/set_servico/:id', :controller=>'orcamentos', :action => 'set_servico_edit'
  get '/orcamentos/delete_servico/:id', :controller=>'orcamentos', :action => 'delete_servico'
  get '/get_empresas', :controller=>'orcamentos', :action => 'get_empresas'

  get '/amostras/get_filtro/:filtro', :controller=>'amostras', :action => 'get_filtro'
  get '/amostras/saveVirtualParametroResultado/:tipo_analise/:parametro/:resultado/:conclusao/:id/:id_resultado', :controller=>'amostras', :action => 'saveVirtualParametroResultado', :parametro => /.+(\/.\%+)*/
  get '/amostras/set_resultado/:id', :controller=>'amostras', :action => 'set_resultado_edit'
  get '/amostras/delete_resultado/:id', :controller=>'amostras', :action => 'delete_resultado'


  root :to => 'application#index'
  #root :to => 'welcome#index'

  match '/home' => 'home#index', via: [:get]

  get '/amostras/:id/copy' => 'amostras#copy', as:  :copy_amostra
  #patch '/amostras/:id/copy' => 'amostras#copy', as:  :copy_amostra
  post '/amostras/:id/copy' => 'amostras#save', as:  :save_amostra
  #post '/amostras/:id/save' => 'amostras#save', as:  :save_amostra

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
