
require "digest/sha1"

class Member < ActiveRecord::Base 

  has_many :hunts # A member can have many hunts
  
  attr_accessor :reset  # reset is a temperary variable that is not stored in the database
  
  
  # Basic form validation
  validates_uniqueness_of :name, :message => "That user name is already taken."
  
  validates_presence_of :name, :message => "Please add a user name."
  validates_presence_of :email, :message => "Please add a valid email."
  validates_numericality_of  :zip, :message => "Please enter a valid zip"
  validates_presence_of  :zip, :message => "Please enter a valid zip"
  validates_presence_of  :state, :message => "Please enter a valid zip"
  validates_presence_of  :city, :message => "Please enter a valid zip"
  validates_length_of :zip, :minimum => 5, :message => "Zip must be 5 numbers"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Please add a valid email."
  validates_uniqueness_of :email, :message => "That email name is already taken."
  
  validates_presence_of :password
  validates_confirmation_of :password, :password_confirmation,:message => " :passwords don't match"

  # The following two methods are 'Callbacks'. The password that comes from the form needs to be hashed
  # before being added to the database.
  # The methed "Calls Back" to the object to update the password field.
  def after_validation_on_create #callback example
      if errors.length == 0 # make sure it's valid ... no validation errors
          self.password = hash_it(self.password)
          send_welcome_email
      end
  end

  def after_validation_on_update
      if errors.length == 0 # make sure it's valid ... no validation errors
          self.password = hash_it(self.password)
      end
  end

  # returns a hashed password
  def hash_it password
    Digest::SHA512.hexdigest password
  end
  
  # Part of the Action Mailer
   def send_welcome_email
      # triggered via:
      # http://localhost:3000/registration/send_welcome_email

      # note the deliver_ prefix, this is IMPORTANT
      Postoffice.deliver_welcome(self.name, self.email)

      # optional, but I like to keep people informed
      #flash[:notice] = "You've successfully registered. Please check your email for a confirmation!"

      # render the default action
      #render :action => 'index'  
    end
    
    def create_reset_password
          self.reset =  Base64.encode64(Digest::SHA1.digest("#{rand(1<<64)}/#{Time.now.to_f}/#{Process.pid}/#{self.name}"))[0..7]
    end
    
    def send_reset_email
      Postoffice.deliver_reset(self.name, self.email, self.reset)   
    end
    

end
