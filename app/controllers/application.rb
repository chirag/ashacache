# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
#require_dependency .password.
class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  
  # Forces a log-in in all cases but the login page.
  before_filter :authorize, :except => :login
 
  #def authorize  # Old authorize method before HTTP access was added
   # unless logged_in?
    #  flash[:notice] = "You have to be logged in to do that"
   #   redirect_to root_path
   #   false
   # end
 # end
  
# This method will allow a user to authenticate from a command line or desktop application by use 
# of HTTP
 def authorize
     unless logged_in?
         authenticate_or_request_with_http_basic do |name,pass|
             puts "Trying to HTTP login with user:pass #{name}:#{pass}"
             member = Member.find_by_name name
             if member and member.password == Digest::SHA512.hexdigest(pass)
                 puts "Http Auth OK - logging user in and return true ..."
                 session[:member_id] = member.id
                 true
              else
                 puts "Http Auth FAILED - redirecting and returning false ..."
                 #redirect_to '/'
                 false
              end
         end
     end
 end
  
  # If the session is not set, how can a member be logged in?
  def logged_in?
 session[:member_id] !=  nil
  end

  # Simple login. Check the parameters from the log-in form
  # Hash the password and then compare it to the hash in the database
  # Good? Then set the session variable with the member ID. Congratulations. You're logged in.
  # No good? Imposter! redirect to the root path
  def login
   unless params[:name].empty? or params[:password].empty?
     member = Member.find_or_create_by_name params[:name]
     if member.password == Digest::SHA512.hexdigest(params[:password])
     session[:member_id] = member.id
    else
     flash[:notice] = 'User and password not found'
    end
   end
   redirect_to '/'
 end
  
  # Logout.  Kill the session. Kill the member.
  def logout
    session[:member_id] = nil
        redirect_to '/'
  end
  
  # Moved from the controller
  def password
    @member = Member.find(params[:id])
  end
   
end