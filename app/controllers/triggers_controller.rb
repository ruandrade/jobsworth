# encoding: UTF-8
class TriggersController < ApplicationController
  layout  "admin"
  before_filter :authorize_user_is_admin

  # GET /triggers
  # GET /triggers.xml
  def index
    @triggers = current_user.company.triggers

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @triggers }
    end
  end

  # GET /triggers/1
  # GET /triggers/1.xml
  def show
    @trigger = current_user.company.triggers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trigger }
    end
  end

  # GET /triggers/new
  # GET /triggers/new.xml
  def new
    @trigger = Trigger.new(:trigger_type => "due_at")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trigger }
    end
  end

  # GET /triggers/1/edit
  def edit
    @trigger = current_user.company.triggers.find(params[:id])
  end

  # POST /triggers
  # POST /triggers.xml
  def create
    @trigger = Trigger.new(params[:trigger])
    @trigger.company = current_user.company

    respond_to do |format|
      if @trigger.save
        flash[:success] = _("Trigger was successfully created.")
        format.html { redirect_to(triggers_path) }
        format.xml  { render :xml => @trigger, :status => :created, :location => @trigger }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trigger.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /triggers/1
  # PUT /triggers/1.xml
  def update
    @trigger = current_user.company.triggers.find(params[:id])

    respond_to do |format|
      if @trigger.update_attributes(params[:trigger])
        flash[:success] = 'Trigger was successfully updated.'
        format.html { redirect_to(triggers_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trigger.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /triggers/1
  # DELETE /triggers/1.xml
  def destroy
    @trigger = current_user.company.triggers.find(params[:id])
    @trigger.destroy

    respond_to do |format|
      format.html { redirect_to(triggers_url) }
      format.xml  { head :ok }
    end
  end
end
