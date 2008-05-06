# This is the basic controller to create, edit, update and destory members. Members can own many hunts. Members can subscribe to many hunts.

class MembersController < ApplicationController
  # GET /members
  # GET /members.xml

  # Force login unless page is public
  before_filter :authorize, :except => [:index,:show,:new,:create, :lost, :reset] 
  
  def index
    @members = Member.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.xml
  def create
    @member = Member.new(params[:member])
 
    respond_to do |format|
      if @member.save
        flash[:notice] = 'Member was successfully created.'
        # Send a welcome email
        format.html { redirect_to(@member) }
        format.xml  { render :xml => @member, :status => :created, :location => @member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.xml
  def update
    @member = Member.find(params[:id])
    
    respond_to do |format|
      if @member.update_attributes(params[:member])
        flash[:notice] = 'Member was successfully updated.'
        format.html { redirect_to(@member) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end
  
  def reset
    if @member = Member.find_by_email(params[:email])
    @member.password = @member.create_reset_password
    @member.save
  
      if @member.send_reset_email
        flash[:notice] = 'Check your email for a reset password'
      end
  else
    flash[:notice] = 'Sorry, email not found'
  end
  render :template => 'members/lost'
  end
  
end