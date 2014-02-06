Mp::Application.routes.draw do
  get    '/sign_in'       => 'sessions#new'
  post   '/sign_in'       => 'sessions#create'
  get    '/sign_out'      => 'sessions#destroy'
  get    '/sign_up'       => 'sessions#sign_up'
  post   '/sign_up'       => 'sessions#sign_up'
  get    '/validate'      => 'sessions#validate'

  get    '/register/:tag'     => 'check#register'
  get    '/search'        => 'search#index'

  resources :images do
    collection do
      post   ':type', action: :create # 图片上传
      post   'cut', action: :cut # 图片上传
    end
  end

  resources :galleries
  resources :albums
  resources :groups, path: 'g'
  resources :events, path: 'e'
  resources :users, path: 'u'
  
  resources :works
  ##### my star #####
  scope '/my', module: 'my', as: 'my' do
    get '/' => 'sets#index'
    resources :sets, only: [:index, :create], path: 'set' do
      collection do
        get 'basic'
        get 'avatar'
        get 'security'
        get 'push'
        get 'dy'
        get 'privacy'
        get 'bg'
        get 'others'
      end
    end

    resources :msgs do
      collection do
        get 'read'
        get 'unread'
        get 'trash'
        get 'notices'
        # get 'read_notices'
        # get 'unread_notices'
      end
    end
    resources :timelines
    resources :albums
    resources :works
    resources :users do
      collection do
        get 'fans'
        get 'follows'
      end
    end
    resources :join_projects do
      collection do
        get 'events'
        get 'groups'
      end
    end
  end
  ##### my end #####

  scope '/admin', :module => 'admin', :as => 'admin' do
    get    '/'              => 'sessions#index'
    # resources :products do
    # end
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
  # 图片原图访问权限
  get "/system/:class/:id/:up/:one/:two/:three/:style/:random.:format" => 'system#show'
  root :to => 'sessions#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
