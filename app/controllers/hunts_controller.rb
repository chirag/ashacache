# The Hunts controller will create, edit, update and destory various hunts. Hunts belong to users. Users can have many hunts.

class HuntsController < ApplicationController

  # Force login, unless authorized. 
  before_filter :authorize, :except => [:index,:show,:query,:search]  # GET /hunts.xml
 
  def index
    @hunts = Hunt.find(:all, :order => "hunts.created_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hunts }
    end
  end

  # GET /hunts/1
  # GET /hunts/1.xml
  def show
    @hunt = Hunt.find(params[:id])
      respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hunt }
    end
  end

  # GET /hunts/new
  # GET /hunts/new.xml
  def new
    @hunt = Hunt.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hunt }
    end
  end

  # GET /hunts/1/edit
  def edit
    @hunt = Hunt.find(params[:id])
    @hunt.prepare_lon_lat_for_edit
    @hunt.save
  end

  # POST /hunts
  # POST /hunts.xml
  def create
    @hunt = Hunt.new(params[:hunt])
    respond_to do |format|
      if @hunt.save
        # Attachment Fu Image Plugin
        # If an image was uploaded, add it to the Image class and link it the Hunt class
        if !params[:image][:uploaded_data].blank?
          @hunt.image = Image.create(params[:image])     
        end
        flash[:notice] = 'Hunt was successfully created.'
        format.html { redirect_to(@hunt) }
        format.xml  { render :xml => @hunt, :status => :created, :location => @hunt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hunt.errors, :status => :unprocessable_entity }
      end
    end
  end  

  # PUT /hunts/1
  # PUT /hunts/1.xml
  def update
    @hunt = Hunt.find(params[:id])

    respond_to do |format|
      if @hunt.update_attributes(params[:hunt])
        
        # Attachment Fu Image Plugin
        # If an image was uploaded, add it to the Image class and link it the Hunt class
        if !params[:image][:uploaded_data].blank?
          #find current image
          @image = @hunt.image ||= Image.new
          @image = @hunt.image.build(params[:image])
          @image.save       
        end
        flash[:notice] = 'Hunt was successfully updated.'
        format.html { redirect_to(@hunt) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml } # => @hunt.errors, :status => :unprocessable_entity
      end
    end
  end

  # DELETE /hunts/1
  # DELETE /hunts/1.xml
  def destroy
    @hunt = Hunt.find(params[:id])
    @hunt.destroy

    respond_to do |format|
      format.html { redirect_to(hunts_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    @query=params[:query]
    @hunts = Hunt.find_by_contents(@query)
    if !@hunts.empty?
     render :template => 'hunts/index'
   else
     flash[:notice] = 'No records were found'
     render :template => 'hunts/query'
   end
  end

  # VERY IMPORTANT If you need a method accesable by both the view and the controller,
  # Use a helper mehtod.
  helper_method :decimal_to_degrees 
    
    protected
    
    # Probably Trash
    #def authenticate
     # authenticate_or_request_with_http_basic do |name,password|
      #name == "remi" && password == "lander"
      #end
    #end
end