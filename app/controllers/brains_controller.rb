class BrainsController < ApplicationController
load_and_authorize_resource
  def recount_all
  	
  	if City.recount and Type.recount and Category.recount
		redirect_to :back 
	else
		flash[:alert] = "Something went Wrong !"
		redirect_to :back
	end
  end

end