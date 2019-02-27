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
		resources :discipline do
			resources :bikes, only: [:index]
		end
		get '', to: 'base#index'
		get '/inventory', to: 'base#inventory', as: 'base'
		get '/inventory/edit', to: 'base#edit', as: 'base_edit'
	end
end
