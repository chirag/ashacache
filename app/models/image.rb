class Image < ActiveRecord::Base
  
  belongs_to :hunt # A hunt can have one image
  
  # This is setting the parameters of the image uploaded from the 'create/update' hunt form
  has_attachment :content_type => ['application/jpg', :image], 
                   :storage => :file_system,
                   :thumbnails => { :thumb => '250x250>'},
                   :max_size => 500.kilobytes,
                   :resize_to => '400x400>'

  # Runs the validation on the image to make sure it is within the above parameters
  validates_as_attachment
end

