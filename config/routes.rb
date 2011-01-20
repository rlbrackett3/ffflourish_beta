Ffflourish::Application.routes.draw do


  # named routes for feeds
  get '/popular' => 'popular_posts#index', :as => 'popular'
  get "popular_posts/index"
  get "popular_posts/show"


  devise_for :users
  #  How To: Redirect to a specific page on successful sign in
  #  redirect to another namespace that is outside of the user namespace
  #match '/profile/:id' => 'profiles#show', :as => 'profile'

  resources :users do
    member do
      match 'follow', 'unfollow'
      get :following, :followers
    end
    resource :profile, :only => [:show, :edit, :update]
    resources :posts do
      member do
        match 'like'
      end
      resources :comments, :only => [:create, :destroy]
    end
  end

  resources :posts do
    member do
      match 'like'
    end
    resources :comments, :only => [:create, :destroy]
  end

#  resource :profile, :only => [:show, :edit, :update]

  devise_scope :user do
    get "/signin"     => "devise/sessions#new"
    match "/signout"  => "devise/sessions#destroy"
    get "/signup"     => "devise/registrations#new"
  end

  # named routes for user resources
  match '/:id'          => 'users#show', :as => 'user'
  match '/:id/following'=> 'pages#home', :as => 'user_following'

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

