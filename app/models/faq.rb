class Faq < ActiveRecord::Base
  validates_presence_of :title, :message => "is empty."
  validates_presence_of :body, :message => "is empty."
  
end
