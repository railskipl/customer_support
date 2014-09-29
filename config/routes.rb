Jmd::Application.routes.draw do
  resources :search, :only => [:index]
  get "/search/reviews" => "reviews#search_reviews", as: :search_reviews
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => {:registrations => "users/registrations",:sessions => "users/sessions", :confirmations => "users/confirmations"}
  root 'welcome#index'

  resources :admin, :only=>[:index]

  match 'searches' => 'admin#searches', via: [:get]
  resources :reviews do
	  resources :comments
  end
  match '/conversions'=> 'companies#conversions', as: :conversions, via: [:get, :post]
  match '/registered'=> 'companies#registered', as: :registered, via: [:get, :post]
  match '/unregistered'=> 'companies#unregistered', as: :unregistered, via: [:get, :post]
  match '/user-review'=> 'companies#user_review', as: :user_review, via: [:get, :post]
  match '/polls-bloppers'=> 'companies#polls_bloopers', as: :polls_bloopers, via: [:get, :post]

	get '/contact_us'=> 'contact_us#new', as: :contact_us

  resources :contact_us,:only => [:new, :create]
  resources :results
  resources :users,:only=>[:update,:edit]
  get '/resources/:slug' => 'resources#show', as: :resource


  match "/profile" => "users#show", via: [:get]
  match "/edit/profile" => "users#edit", via: [:get]
  match "/check_availiblity/user/preferred_alias"=> 'page#check_availiblity', via: [:get]
  get '/industry/companies_by_industry' => "reviews#companies_by_industry"
  get '/company/towns_by_company' => "reviews#towns_by_company"
  get '/town/locations_by_town_and_company' => "reviews#locations_by_town_and_company"
  get "/faqs" => "faqs#index",as: :faqs
  match "/:slug" => "pages#index",via: [:get],as: :page
  resources :polls ,:only => [:show]

  namespace :admin do
    get "/searches/reviews" => "reviews#search_reviews", as: :search_reviews
    get "change_password" => "users#change_password", as: :change_password
    put "update_password" => "users#update_password", as: :update_password
  	resources :users
  	resources :locations
  	resources :towns
  	resources :companies
  	resources :industries
  	resources :nature_of_reviews
  	resources :reviews do
  	  resources :comments
  	end
  	resources :addresses
  	resources :polls
  	resources :faqs
  	resources :pages, :only => [:index, :edit, :update]
  	resources :resources
  	resources :agents
  	resources :advertises
  	resources :suppliers
  	resources :resource_types
    resources :seos
  end
end
