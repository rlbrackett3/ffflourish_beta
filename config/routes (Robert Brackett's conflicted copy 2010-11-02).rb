Ffflourish::Application.routes.draw do

  get "scaffold/posts"

  devise_scope :user do
    get "/signin"   => "devise/sessions#new"
    match "/signout"  => "devise/sessions#destroy"
    get "/signup"   => "devise/registrations#new"
  end
  devise_for :users
  #  How To: Redirect to a specific page on successful sign in
  #  redirect to another namespace that is outside of the user namespace
  #match '/profile/:id' => 'profiles#show', :as => 'profile'

  resources :users, :only => [:show]
  resources :profiles, :only => [:show, :edit, :update]
  resources :stats, :only => [:edit, :update] #nest stat in profile

  resources :posts



  match '/about'        => 'pages#about'
  match '/tour'         => 'pages#tour'
  match '/terms'        => 'pages#terms'
  match '/contact'      => 'pages#contact'

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

