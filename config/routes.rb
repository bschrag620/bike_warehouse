Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :bikes, :manufacturers, :frame, only: [:show, :index]
	get '/bikes/sort/:category/:direction', to: 'bikes#index', as: 'bikes_sort'

	resources :disciplines do
		resources :bikes, only: [:index]
	end

	resources :manufacturers do
		resources :bikes, only: [:index]
	end

	namespace :admin do
		resources :bikes
		
		resources :manufacturers do
			resources :bikes, only: [:index]
		end
		
		resources :purchases, only: [:index, :show, :destroy]
		
		resources :frames do
			resources :bikes, only: [:index]
		end
		
		resources :disciplines do
			resources :bikes, only: [:index]
		end

		resources :users do
			get '/purchases', to: 'purchases#index', as: 'purchases'
		end
		
		get '', to: 'base#index'
		get '/inventory', to: 'base#inventory', as: 'base'
		get '/inventory/edit', to: 'base#edit', as: 'base_edit'
	end

	# user routes for signup, login, logout
	resources :users, only: [:new, :create, :update, :show] do
		get '/checkout', to: 'purchases#new', as: 'checkout'
		post '/checkout', to: 'purchases#create', as: 'purchases'
		get '/checkout/:id/payment', to: 'purchases#edit', as: 'payment'
		patch '/checkout/:id/payment', to: 'purchases#update', as: 'purchase'
		get '/receipt/:id', to: 'purchases#show', as: 'receipt'

		resources :shipping_addresses, only: [:edit, :update, :destroy]
		resources :billing_addresses, only: [:edit, :update, :destroy]
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
	
end
