Ffflourish::Application.routes.draw do

  # named routes for feeds
  # feed of most popular posts
  get "popular_posts/index"
  get "popular_posts/show"
  match '/popular' => 'popular_posts#index', :as => 'popular'
  # feed of followed users
  match '/:id/following' => 'following_posts#index', :as => 'user_following'
  get "/following_posts/index"
  # feed of most current posts
  get "current_posts/index"
  get "current_posts/show"
  match '/recent' => 'current_posts#index', :as => 'recent'
  # random post
  get 'random_posts/show'
  match '/random' => 'random_posts#show', :as => 'random'

  devise_for :users, :controllers => {:registrations => "registrations"} 
  
  devise_scope :user do
    get "/signin"     => "devise/sessions#new"
    match "/signout"  => "devise/sessions#destroy"
    get "/signup"     => "registrations#new"
  end

  resources :users do
    member do
      match 'follow', 'unfollow'
      get :following, :followers
    end
    resource :profile,  :only => [:show, :edit, :update]
    resources :posts,   :except => [:show, :new] do
      member do
        match 'like'
        match 'likers'
      end
      resources :comments
    end
  end

  resources :posts, :except => [:show, :new] do
    member do
      match 'like'
      match 'likers'
    end
    resources :comments
  end
  
  post '/posts/create_before_account' => 'posts#create_before_account'
  
  resources :comments

  # named routes for user resources
  match '/:id'          => 'posts#index', :as => 'user_feed'

  # named routes for user profile
  get '/:user_id/profile' => 'profile#show', :as => 'user_profile'
  put '/:user_id/profile' => 'profile#update', :as => 'user_profile'
  match '/:user_id/profile/edit' => 'profile#edit', :as => 'edit_user_profile'

  # general routes
  get '/ffflourish/about'        => 'pages#about',    :as => 'about'
  get '/ffflourish/tour'         => 'pages#tour',     :as => 'tour'
  get '/ffflourish/terms'        => 'pages#terms',    :as => 'terms'
  match '/ffflourish/contact'    => 'pages#contact',  :as => 'contact'

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
  root :to => "pages#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

