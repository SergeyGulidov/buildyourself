class FeedsController < ApplicationController
load_and_authorize_resource

  def index
    @feeds = Feed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end

  def create
    @feed = Feed.new(params[:feed])
    @feed.user_id = current_user.id
    

    respond_to do |format|
      if @feed.save
        format.html { redirect_to :back, notice: t(:success) }
        format.json { render json: @feed, status: :created, location: @feed }
      else
        format.html { redirect_to :back, alert: 'Something went wrong.'  }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def news
    if params[:user].blank?
      @news = Feed.order("created_at").includes(:user).limit(15)
    else
      @news = Feed.select("message, updated_at, place_id").where("user_id = ?", params[:user]).last(10)
      @user = User.select("name, email").where("id = ?", params[:user]).first
    end
  end

end
