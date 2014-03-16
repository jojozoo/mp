Mp::Application.routes.draw do


  get    '/'              => 'sessions#index', as: :sessions
  get    '/sign_in'       => 'sessions#new'
  post   '/sign_in'       => 'sessions#create'
  get    '/sign_out'      => 'sessions#destroy'
  get    '/sign_up'       => 'sessions#sign_up'
  post   '/sign_up'       => 'sessions#sign_up'
  get    '/validate'      => 'sessions#validate'
  get    '/forgot'        => 'sessions#forgot'
  post   '/forgot'        => 'sessions#forgot'

  get    '/profile'       => 'users#profile'
  get    '/search'        => 'search#index'
  match '/ajax/tui/:push/:source/:id' => 'ajax#tui', via: :post, as: :ajax_tui # 推
  match '/ajax/del/:source/:id'       => 'ajax#del', via: :post, as: :ajax_del # 删除
  match '/ajax/com/:source/:id'       => 'ajax#com', via: :post, as: :ajax_com # 评论
  match '/comment/:obj/:id' => 'comments#create', via: :post, as: :comment

  # gallery
  resources :images, path: 'gs' do
    collection do
      get :waterfall
      get :star
    end
    member do
      get :tui
    end
  end
  resources :albums
  resources :topics, path: 't' do
    get :excellent, on: :collection
    get :explore, on: :collection
  end
  resources :events, path: 'e'
  resources :users, path: 'u'
  resources :micros, path: 'ms'
  resources :works
  resources :rs
  # resources :comments
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

    resources :msgs do
      collection do
        get 'read'
        get 'unread'
        get 'trash'
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
    get  '/'     => 'sessions#index'
    get  '/info' => 'sessions#info'
    post '/info' => 'sessions#info'
    get  '/log'  => 'sessions#log'
    get  '/basic'  => 'sessions#basic'
    get  '/refresh'  => 'sessions#refresh'
    resources :feedbacks
    resources :banners
    resources :bgs
    resources :ads do
      member do
        post :putin
        get  :close
        get  :open
        get  :del
      end
    end
    resources :sends
    # resources :products do
    # end
    resources :users, except: [:new, :create]
    resources :images
    resources :events do
      member do
        get :state
        get :totop
      end
    end
    resources :works
    resources :groups
    resources :topics
    resources :talks
    resources :tags
    resources :comments
    resources :tuis
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
  get "/system/:class/:id/:up/:one/:two/:three/:style/:random.:format" => 'images#browse'
  root :to => 'sessions#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
