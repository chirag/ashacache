class CommentsController < ApplicationController

  # Only show public pages unless logged in.
  before_filter :authorize, :except => [:index,:show] 
  
  # Create a comment. Link it to a particular hunt by ID
  def create
  @comment = Comment.new(params[:comment])
  @comment.hunt_id = params[:hunt_id]  #/hunts/:hunt_id/comments
    if @comment.save
      flash[:notice] = "Your comment was saved!"
      redirect_to hunt_url(@comment.hunt)
    else
      @hunt = @comment.hunt   # reset the hunt variable
      flash[:notice] = "Sorry, there was a problem."
      render :template => 'hunts/show'
    end
  end
  
end
