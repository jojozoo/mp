Mp::Application.routes.draw do
  get    '/home'          => 'home#index', as: :home
  get    '/sign_in'       => 'sessions#new'
  post   '/sign_in'       => 'sessions#create'
  get    '/sign_out'      => 'sessions#destroy'
  get    '/sign_up'       => 'sessions#sign_up'
  post   '/sign_up'       => 'sessions#sign_up'
  get    '/validate'      => 'sessions#validate'
  get    '/forgot'        => 'sessions#forgot'
  post   '/forgot'        => 'sessions#forgot'
  get    '/forgotdb'      => 'sessions#forgotdb'
  get    '/findpwd'       => 'sessions#findpwd'
  post   '/findpwd'       => 'sessions#findpwd'

  get    '/profile'       => 'users#profile'
  get    '/pg/:id'        => 'users#pg', as: :pg # 摄影师地址
  get    '/search'        => 'search#index'
  match '/ajax/is_sign_in'            => 'ajax#is_sign_in', via: :get, as: :ajax_is_sign_in # 验证登录
  match '/ajax/tui/:push/:source/:id' => 'ajax#tui', via: :post, as: :ajax_tui # 推
  match '/ajax/del/:source/:id'       => 'ajax#del', via: :post, as: :ajax_del # 删除
  match '/ajax/com/:source/:id'       => 'ajax#com', via: :post, as: :ajax_com # 评论
  match '/ajax/fol/:source/:id'       => 'ajax#fol', via: :post, as: :ajax_fol # 关注
  match '/ajax/ufl/:source/:id'       => 'ajax#ufl', via: :post, as: :ajax_ufl # 取消关注
  match '/ajax/editer/:source/:id'    => 'ajax#editer', via: :post, as: :ajax_editer # 取消关注
  

  # gallery
  resources :photos do
    collection do
      get :waterfall
      get :star
      post :upload
      get :uploadnew
      get :uploadie
    end
    member do
      get :tui
    end
  end

  resources :topics do
    collection do
      get :excellent
      get :explore  
    end
  end
  resources :events, path: 'requests', only: [:index, :show] do
    collection do
      get :waterfall
    end
  end
  resources :users, path: 'accounts' do
    member do
      get :fans
      get :fols
      get :like
      get :store
    end
  end
  resources :works
  resources :collections, path: 'collection'
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
        get 'notices'
      end
    end
    resources :timelines
    resources :albums do
      collection do
        match :upload, via: [:get, :post], as: :upload
      end
      member do
        match 'cover/:image_id' => 'albums#cover', via: :post, as: :cover
        post :move
        post :move_modal
        post :desc
      end
    end
    resources :works
    resources :users do
      collection do
        get 'fans'
        get 'follows'
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
  get "/system/:class/:id/:up/:one/:two/:three/:style/:random.:format" => 'photos#browse'
  root :to => 'sessions#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
