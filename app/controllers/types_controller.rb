class TypesController < ApplicationController
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
end
