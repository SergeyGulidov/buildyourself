class SchedulesController < ApplicationController
load_and_authorize_resource

  def create
    @schedule = Schedule.new(params[:schedule])
    @schedule.user_id = current_user.id
    
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to :back, notice: t(:success) }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { redirect_to :back, alert: 'Something went wrong.'  }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to action: "edit", notice: t(:success) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: t(:success) }
      format.json { head :no_content, alert: 'Something went wrong.'  }
    end
  end
end
