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
	  respond_to do |format|
	    if @type.save
	      redirect_to :action => 'new'
          flash[:notice] = "Your message have successfully sended."
	    else
	      format.html  { render :action => "new" }
	      format.json  { render :json => @type.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
  end
end
