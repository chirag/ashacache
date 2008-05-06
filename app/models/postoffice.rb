class Postoffice < ActionMailer::Base  
# located in models/postoffice.rb
# make note of the headers, content type, and time sent
# these help prevent your email from being flagged as spam
 
  def welcome(name, email)
    @recipients   = email
    @from         = "admin@ashacache.com"
    #@from         = params[:contact][:email]
    headers         "Reply-to" => "#{email}"
    @subject      = "Welcome to Ashacache"
    @sent_on      = Time.now
    @content_type = "text/html"
 
    body[:name]  = name
    body[:email] = email       
  end
  
  def reset(name, email,reset)
    @recipients   = email
    @from         = "admin@ashacache.com"
    #@from         = params[:contact][:email]
    headers         "Reply-to" => "#{email}"
    @subject      = "Password Reset for Ashacache"
    @sent_on      = Time.now
    @content_type = "text/html"
 
    body[:name]  = name
    body[:email] = email
    body[:reset] = reset      
  end
  
  def contact(title,email,message)
    @recipients   = "lance@lancewig.com"
    @from         = "contact@ashacache.com"
    #@from         = params[:contact][:email]
    headers         "Reply-to" => "#{email}"
    @subject      = "Contact from Ashacache"
    @sent_on      = Time.now
    @content_type = "text/html"
 
    body[:title]  = title
    body[:email] = email
    body[:message] = message  # 'message' is used because 'body' conflicts with the post office object  
  end
 
end
