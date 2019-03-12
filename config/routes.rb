Rails.application.routes.draw do
  get 'reviews/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :frame, only: [:show, :index]
	get '/bikes/sort/:category/:direction', to: 'bikes#index', as: 'bikes_sort'

	resources :manufacturers, :disciplines, only: [:show, :index] do
		resources :bikes, only: [:index]
		get 'bikes/sort/:category/:direction', to: 'bikes#index', as: 'bikes_sort'
	end

	namespace :admin do
		resources :bikes
		
		resources :manufacturers do
			resources :bikes, only: [:index, :new, :create]
		end
		
		resources :purchases, only: [:index, :show, :destroy]
		
		resources :disciplines do
			resources :bikes, only: [:index]
		end

		resources :frames, only: [:index, :show, :edit, :update, :create, :new, :destroy] do
			resources :bikes, only: [:new, :create]
		end

		resources :users do
			resources :purchases, only: [:index, :show]
		end
		
		get '', to: 'base#index'
		get '/inventory', to: 'base#inventory', as: 'base'
		get '/inventory/edit', to: 'base#edit', as: 'base_edit'
		get '/inventory/new', to: 'base#new', as: 'base_new'
	end

	# user routes for signup, login, logout
	resources :users, only: [:new, :create, :update, :show, :edit] do
		get '/checkout', to: 'purchases#new', as: 'checkout'
		post '/checkout', to: 'purchases#create', as: 'purchases'
		get '/checkout/:id/payment', to: 'purchases#edit', as: 'payment'
		patch '/checkout/:id/payment', to: 'purchases#update', as: 'purchase'
		get '/receipt/:id', to: 'purchases#show', as: 'receipt'

		resources :shipping_addresses, only: [:create, :edit, :update, :destroy]
		resources :billing_addresses, only: [:create, :edit, :update, :destroy]
		resources :purchases, only: [:index]
	end
	get '/users', to: 'session#signup'
	get '/login', to: 'session#login', as: 'login'
	post '/login', to: 'session#validate', as: 'validate_login'
	post '/logout', to: 'session#logout', as: 'logout'
	get '/signup', to: 'session#signup', as: 'signup'

	# cart routes
	get '/cart', to: 'session#shopping_cart', as: 'cart'
	post '/cart', to: 'session#add_to_cart', as: 'add_to_cart'
	delete '/cart/:id', to: 'session#remove_item', as: 'remove_from_cart'

	# purchase routes
	#sresources :purchases, only: [:new, :create, :edit, :update]
	

	# home page
	root to: 'session#index', as: 'root'

	# address routes
	resources :addresses, only: [:new, :create]

	#omniauth routes
	get '/auth/facebook/callback', to: 'session#create'

	resources :reviews, only: [:create]
	
end
