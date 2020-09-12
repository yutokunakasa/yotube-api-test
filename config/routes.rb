Rails.application.routes.draw do
	get 'input' => 'microposts#search'
	root 'microposts#search'
	get 'search_micropost' => 'microposts#search'
	post 'search_micropost' => 'microposts#search'

	resources :movies
end
