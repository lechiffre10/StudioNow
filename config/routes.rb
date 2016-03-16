Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  resources :users, except: [:index] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    resources :rates, only: [:create, :update]
  end

  resources :studios do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    resources :rates, only: [:create, :update]
    resources :images, only: [:index, :show, :new, :create, :destroy]
    resources :availabilities do
      resources :bookings, only:[:create, :destroy]
    end
  end

  resources :conversations, except: [:new, :create] do
    resources :messages, only:[:new, :create, :destroy]
  end


  get '/logout' => 'users#destroy', as: 'logout'
  post '/login' => 'users#login', as: 'login'

  get '/conversations/:recipient_id/create' => 'conversations#create', as: 'create_conversation'

  get '/availabilities/get' => 'availabilities#get_availabilities'
  post '/availabilities/move' => 'availabilities#move'
  post '/availabilities/resize' => 'availabilities#resize'
  get '/availabilities/get_slots' => 'availabilities#get_available_timeslots'
  root 'welcome#index'

  get '/find_average/*speed' => 'users#find_average', :constraints => { :speed => /.*/ }
end
