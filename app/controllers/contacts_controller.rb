class ContactsController < ApplicationController
load_and_authorize_resource
  
  def new
  	@contact = Contact.new
    @contact.email = current_user.email if current_user
  	respond_to do |format|
  		format.html  # new.html.erb
  		format.json  { render :json => @contact }
  	end
  end

   def create
      @contact = Contact.new(params[:contact])
      if  @contact.save
            redirect_to :action => 'new'
            flash[:notice] = "Your message have successfully sended."
      else
            render :action => 'new'
      end
   end

  def index
  	@contacts = Contact.find(:all)
  end

  def destroy
    Contact.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
