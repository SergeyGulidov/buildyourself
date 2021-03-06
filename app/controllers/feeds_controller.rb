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
        UserMailer.delay(priority: 90).new_feed_notifier(@feed)
        format.html { redirect_to :back, notice: t(:success) }
      else
        format.html { redirect_to :back, alert: 'Something went wrong.'  }
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
  end

end
