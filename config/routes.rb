ActionController::Routing::Routes.draw do |map|
  map.resources :contacts
  map.resources :documentations
  map.resources :faqs

  #map.resource :sessions  Junk?
  # Possible fix??? map.resource :session, :controller => ‘session’

  map.login '/login/', :controller => 'application', :action => 'login'
  map.logout '/logout/', :controller => 'application', :action => 'logout'
  map.query '/query',:controller =>'hunts',:action => 'query'
  
  map.resources :faqs
    
  # Nested comment resources
  map.resources :hunts do |hunts|
    # /chapters/1/comments/7
    # comments_path(id_of_hunt, id_of_hunt) ???
    hunts.resources :comments
  end
  
  map.resources :members, :member => {:update_password => :put  }
  
  map.signup '/signup', :controller => 'members', :action => 'new'
  map.password 'members/:id/password', :controller => 'members', :action => 'password'
  map.reset '/reset', :controller => 'members', :action => 'reset'
  map.lost '/lost', :controller => 'members', :action => 'lost'
  

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "hunts"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
