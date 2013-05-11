class RequestsController < ApplicationController
load_and_authorize_resource

  def index
    @requests = Request.all

    respond_to do |format|
      format.html
      format.json { render json: @requests }
    end
  end

  def new
    @request = Request.new

    respond_to do |format|
      format.html 
      format.json { render json: @request }
    end
  end


  def create
    @request = Request.new(params[:request])

    respond_to do |format|
      if @request.save
        format.html { redirect_to root_path, notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end

  def subscribe
    respond_to do |format|
      format.html 
      format.json { render json: @request }
    end
  end


  def waitingforactivation
    redirect_to subscribe_path, notice: t(:confirmation_email_sended)
  end

  def subscribed
    redirect_to subscribe_path, notice: t(:you_are_subscribed)
  end


end
