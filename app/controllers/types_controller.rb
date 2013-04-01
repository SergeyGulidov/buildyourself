class TypesController < ApplicationController
load_and_authorize_resource
	before_filter :find_type, :only => [:edit, :update, :destroy]
	
  def index
    @types = Type.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @types }
    end
  end

  def new
  	@type = Type.new
  	respond_to do |format|
  		format.html  # new.html.erb
  		format.json  { render :json => @type }
  	end
  end

  def create
	  @type = Type.new(params[:type])
	  if @type.save
	    	redirect_to :action => 'new'
        	flash[:notice] = "Type has added !"
	  else
	    	render :action => 'new'
	  end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @type.update_attributes(params[:type])
        format.html { redirect_to action: "index", notice: 'Type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
   end	

  def destroy
    @type.destroy
    redirect_to action: "index"
  end

  def find_type
  	@type = Type.find(params[:id].to_i)
  end
end
