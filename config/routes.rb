ActionController::Routing::Routes.draw do |map|
  map.login  'login',  :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.resources :stars do |stars|
    stars.resources :seconds
  end
  map.resources :user_sessions
  map.resources :users

  map.root      :stars
end
