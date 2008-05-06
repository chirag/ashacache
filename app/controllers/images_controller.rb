class ImageController < ApplicationController
  
  # Force login to make changes
  before_filter :authorize, :except => [:index,:show] 
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:uploaded_data])
    if @image.save
      flash[:notice] = 'Image was successfully created.'
    else
      render :action => :new
    end
  end
  
end
