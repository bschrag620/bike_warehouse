Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :bikes, :manufacturers, :frame, only: [:show, :index]

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
		resources :frames do
			resources :bikes, only: [:index]
		end
		resources :disciplines do
			resources :bikes, only: [:index]
		end
		get '', to: 'base#index'
		get '/inventory', to: 'base#inventory', as: 'base'
		get '/inventory/edit', to: 'base#edit', as: 'base_edit'
	end

	# user routes for signup, login, logout
	resources :users, only: [:new, :create, :update]
	get '/users', to: 'session#signup'
	get '/login', to: 'session#login', as: 'login'
	post '/login', to: 'session#validate', as: 'validate_login'
	post '/logout', to: 'session#logout', as: 'logout'
	get '/signup', to: 'session#signup', as: 'signup'

	# cart routes
	get '/cart', to: 'session#shopping_cart', as: 'cart'
	post '/cart', to: 'session#add_to_cart', as: 'add_to_cart'
	delete '/cart', to: 'session#remove_item', as: 'remove_from_cart'

	# purchase routes
	get '/checkout', to: 'purchases#new', as: 'checkout'
	get '/payment', to: 'purchases#payment', as: 'payment'

	# home page
	root to: 'session#index', as: 'root'

	# address routes
	resources :addresses, only: [:new, :create]
	
end
