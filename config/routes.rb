BuildYourSelf::Application.routes.draw do

  


  


  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    

    root :to => 'places#index'
    devise_for :users, :controllers => {
      :registrations => "registrations", 
      :passwords => "passwords", 
      :sessions => "sessions",
      omniauth_callbacks: "omniauth_callbacks"
    }
    match 'places/approve' => 'places#approve'
    match '/places/:id/make_approve' => 'places#make_approve'
    match 'places/translate' => 'places#translate'
    match '/places/:id/make_translate/' => 'places#make_translate'
    match '/posts/unapproved' => 'posts#unapproved'
    match '/posts/approve' => 'posts#approve'
    resources :photos
    resources :places # do
      #member { post :vote }
      #collection { post :q, to: 'products#index' }
    #end
    match '/recount' => 'brains#recount_all', as: 'recount'
    match '/subscribed' => 'requests#subscribed'
    match '/waitingforactivation' => 'requests#waitingforactivation'
    match '/subscribe' => 'requests#subscribe', as: 'subscribe'
    match 'feeds/news' => 'feeds#news', :defaults => {:format => 'rss'}
    resources :requests, :only => [:index, :new, :create, :destroy]
    resources :contacts, :only => [:index, :new, :create, :destroy]
    resources :categories
    resources :cities
    resources :countries
    resources :users
    resources :types
    resources :posts
    resources :feeds, :only => [:index, :create, :destroy]

    resources :schedules

    match '/:id' => 'places#show', :via => 'get'
    
  end
end
