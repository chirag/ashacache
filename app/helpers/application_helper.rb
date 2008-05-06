require 'maruku'
module ApplicationHelper     
  def admin?
    if current_member
      current_member.name.downcase == 'lance' or  current_member.name.downcase == 'remi' #Accepts 'Lance' or 'lance'
    else
      false
    end  
  end
   
  def logged_in?
       current_member
  end
  
  def current_member
    Member.find session[:member_id] if session[:member_id]
  end 
  
  def markdown text
      Maruku.new(text).to_html
  end



end