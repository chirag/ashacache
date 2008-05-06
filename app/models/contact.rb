class Contact < ActiveRecord::Base
  
  
  validates_presence_of :title, :message => "Please add a title."
  validates_presence_of :email, :message => "Please add an email."
  validates_presence_of :body, :message => "Please add a message."
  
  def after_validation_on_create #callback example
      if errors.length == 0 # make sure it's valid ... no validation errors
          send_contact_email
      end
  end
  
  # send the contact form message to the administrator
  def send_contact_email
     Postoffice.deliver_contact(self.title, self.email, self.body)
   end
  
end
