class ContactsController < ApplicationController
  load_and_authorize_resource
  
  def new
  	@contact = Contact.new
	 
  	respond_to do |format|
  		format.html  # new.html.erb
  		format.json  { render :json => @contact }
  	end
  end

   def create
      @contact = Contact.new(params[:contact])
      if @contact.save
            redirect_to :action => 'new'
            flash[:notice] = "Your message have successfully sended."
      else
            render :action => 'new'
      end
   end

  def show
  	@contacts = Contact.find(:all)
    authorize! :show, @contacts
  end

  def destroy
    #authorize! :destroy, @contacts
    Contact.find(params[:id]).destroy
    redirect_to :action => 'show'

  end
end
