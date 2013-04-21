class UsersController < ApplicationController

load_and_authorize_resource

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end


  def edit
    @user = User.find(params[:id])
    @current_user_places ||= Place.where("user_id = ?", current_user.id ).all if current_user
  end

  def show
    @user = User.find(params[:id])
    @user_places ||= Place.approved.where("user_id = ?", @user.id).all
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t(:user_updated)
        format.html { redirect_to action: "edit" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.json { head :no_content }
    end
  end

end
