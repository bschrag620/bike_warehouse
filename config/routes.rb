Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :bikes, :manufacturers, :frame, only: [:show, :index]

	namespace :admin do
		resources :bikes, :manufacturers, :frames
	end

  get '/bikes/sort_by/:sort_by', to: 'bikes#index', as: 'sort_bikes'
end
