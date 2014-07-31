Mp::Application.routes.draw do
  get    '/home'          => 'home#index', as: :home
  post   '/sign_in'       => 'sessions#create'
  post   '/sign_up'       => 'sessions#sign_up'
  get    '/sign_out'      => 'sessions#destroy'
  get    '/forgot'        => 'sessions#forgot'
  post   '/forgot'        => 'sessions#forgot'
  get    '/reset'         => 'sessions#reset', as: :reset
  post    '/reset'         => 'sessions#reset'
  get    '/verif'         => 'sessions#verif', as: :verif

  # get    '/profile'       => 'users#profile'
  get    '/pg/:id'        => 'users#pg', as: :pg # 摄影师地址
  get    '/search'        => 'search#index'
  match  '/validations/:action'       => 'validations#:action'
  

  # match '/ajax/tui/:push/:source/:id' => 'ajax#tui', via: :post, as: :ajax_tui # 推
  # match '/ajax/editer/:source/:id'    => 'ajax#editer', via: :post, as: :ajax_editer # 推荐精选
  
  match '/ajax/del/:source/:id'       => 'ajax#del', via: :post, as: :ajax_del # 删除
  match '/ajax/com/:source/:id'       => 'ajax#com', via: :post, as: :ajax_com # 评论
  match '/ajax/tag/:source/:id'       => 'ajax#tag', via: :get , as: :ajax_tag # 获取标签
  
  # match '/ajax/tui/:source/:id'       => 'ajax#tui', via: :post, as: :ajax_tui # 推荐精选
  match '/ajax/lik/:source/:id'       => 'ajax#lik', via: :post, as: :ajax_lik # 喜欢
  match '/ajax/sto/:source/:id'       => 'ajax#sto', via: :post, as: :ajax_sto # 收藏
  match '/ajax/rec/:source/:id'      => 'ajax#rec', via: :post, as: :ajax_rec # 推荐精选
  match '/ajax/cho/:source/:id'       => 'ajax#cho', via: :post, as: :ajax_cho # 每日精选
  match '/ajax/fol/:source/:id'       => 'ajax#fol', via: :post, as: :ajax_fol # 关注 # 取消关注
  match '/ajax/msg/:source/:id'      => 'ajax#msg', via: :get , as: :ajax_msg # 发送消息
  
  resources :ueditors
  resources :tps, only: [:create, :show]
  # gallery
  resources :photos do
    collection do
      get :waterfall
      get :star
      post :upload
      get :uploadnew
      get :uploadswf
      get :simple
      get :complex
      post :simple_create
      post :complex_create
    end
    member do
      get :simple_edit
      get :complex_edit
      put :simple_update
      put :complex_update
    end
  end

  resources :topics do
    collection do
      get :excellent
      get :explore  
      get 'cate/:cate_id', action: :cate, as: :cate
    end
  end
  resources :events, path: 'requests', only: [:index, :show]
  
  resources :users, path: 'accounts' do
    collection do
      get :setpbg
    end
    member do
      get :fans
      get :fols
      get :like
      get :store
      get :albums
      get '/:album_id/photos', action: :photos, as: :photos_album
    end
  end
  resources :works
  resources :collections, path: 'collection'
  resources :choices
  resources :sites, only: :create do
    collection do
      match ':action'
    end
  end

  scope '/oauth', module: 'oauth' do
    get 'sign_in/:id' => 'application#index', as: :oauth_sign_in
    [:weibo, :qq, :qqmp, :qzone, :douban, :renren].each do |row|
      resources row, only: [:index] do
        collection do
          get  'callback'
        end
      end
    end
    
  end
  
  ['information', 'avatar', 'security', 'push', 'socials'].each do |r|
    match "/settings/#{r}" => "settings##{r}", via: [:get, :post], as: "settings_#{r}".to_sym
  end
  match "/settings"    => "settings#index"
  post "/settings/cut" => "settings#cut"
  ##### my star #####
  scope '/my', module: 'my', as: 'my' do
    get '/' => 'sets#index'
    resources :sets, only: [:index, :update], path: 'set' do
      collection do
        get  'basic'
        post 'avatar'
        get  'avatar'
        post 'cut'
        get  'security'
        post 'update_pass'
        get  'push'
        post 'push'
        # get  'dy'
        # get  'privacy'
        get  'bg'
        get  'others'
      end
    end
    # :path_names => {show: 'manmail' }
    resources :msgs do
      collection do
        match 'write/:user_id' => "msgs#write", via: :get, as: :write
        # get 'notices'
      end
    end
    resources :notices, only: [:index, :show, :destroy, :edit]
    resources :albums do
      # collection do
      #   match :upload, via: [:get, :post], as: :upload
      # end
      member do
        match 'cover/:image_id' => 'albums#cover', via: :post, as: :cover
        post :move
        post :move_modal
        post :desc
      end
    end
  end
  ##### my end #####
  
  scope '/admin', :module => 'admin', :as => 'admin' do
    mount Resque::Server => '/resque'
    get '/ajax/:action', controller: 'ajax', as: :ajax

    get  '/'     => 'sessions#index'
    get  '/msg' => 'sessions#msg'
    post '/msg' => 'sessions#msg'
    
    resources :mp_sets
    resources :feedbacks
    resources :banners
    resources :users
    resources :editors
    resources :works
    resources :tags
    resources :comments
    resources :events
    resources :topics
    resources :tuis

    resources :photos do
      collection do
        get :all
      end
      member do
        get :basic
      end
    end
    
    
    resources :messages, only: [:index, :show, :destroy] do
      get :talk, on: :member
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # 图片访问权限
  get "/system/photos/:id/:up/:one/:two/:three/:style/:random.:format" => 'photos#browse'
  get "/system/tps/:id/:one/:two/:three/:style/:random.:format"    => 'tps#show'
  root :to => 'sessions#index'
  match '*path', to: redirect {|pms, req| Logger.new(STDOUT).info("route_error path: #{req.url}, ip: #{req.remote_ip}");"/404"}
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
