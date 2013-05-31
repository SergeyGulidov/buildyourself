class SubscribersController < ApplicationController
	load_and_authorize_resource

  def index
    @active = Subscriber.active
    @not_confirmed = Subscriber.not_confirmed

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscribers }
    end
  end

  def create
    @subscriber = Subscriber.new(params[:subscriber])

    respond_to do |format|
      if @subscriber.save
        UserMailer.greating(@subscriber.email, @subscriber.confirm_token).deliver

        format.html { redirect_to :back, notice: t(:send_instructions) }
        format.json { render json: @subscriber, status: :created, location: @subscriber }
      else
        format.html { redirect_to :back, alert: 'Something went wrong.'  }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscriber = Subscriber.where(confirm_token: params[:token]).first
    if @subscriber
      if @subscriber.destroy
        redirect_to root_path, notice: t(:success)
      else
        redirect_to root_path, notice: 'Something went wrong.'
      end
    end 
  end

  def confirm
    @subscriber = Subscriber.where(confirm_token: params[:token]).first
    if @subscriber
      @subscriber.confirmed = 1
      if @subscriber.save
        redirect_to root_path, notice: t(:success)
      else
        redirect_to root_path, notice: 'Something went wrong.'
      end
    end 
  end

end
