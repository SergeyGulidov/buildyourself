class BywaysController < ApplicationController
load_and_authorize_resource

  def create
    @byway = Byway.new(params[:byway])
    @byway.user_id = current_user.id
    respond_to do |format|
      if @byway.save
        format.html { redirect_to :back, notice: t(:success) }
      else
        format.html { redirect_to :back, alert: 'Something went wrong.'  }
      end
    end
  end

  def destroy
    @byway = Byway.find(params[:id])
    @byway.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
