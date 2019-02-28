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

	resources :users, only: [:new, :create]
	get '/users', to: 'session#signup'

	root to: 'session#index', as: 'root'
	get '/login', to: 'session#login', as: 'login'
	post '/login', to: 'session#validate', as: 'validate_login'
	post '/logout', to: 'session#logout', as: 'logout'
	get '/signup', to: 'session#signup', as: 'signup'
end
