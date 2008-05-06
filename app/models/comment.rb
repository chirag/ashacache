class Comment < ActiveRecord::Base

  # A Hunt can have many comments
  belongs_to :hunt

  # Validate all the form fields when adding a comment
  validates_presence_of :name, :message => "Please add a name."
  validates_presence_of :title, :message => "Please add a title."
  validates_presence_of :body, :message => "Please add a comment."

end
