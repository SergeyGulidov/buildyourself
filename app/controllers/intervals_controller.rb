class IntervalsController < ApplicationController
 load_and_authorize_resource

  def index
    @intervals = Interval.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @intervals }
    end
  end

  def new
    @interval = Interval.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interval }
    end
  end

  def edit
    @interval = Interval.find(params[:id])
  end

  def create
    @interval = Interval.new(params[:interval])

    respond_to do |format|
      if @interval.save
        format.html { redirect_to action: "new", notice: 'Interval was successfully created.' }
        format.json { render json: @interval, status: :created, location: @interval }
      else
        format.html { render action: "new" }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @interval = Interval.find(params[:id])

    respond_to do |format|
      if @interval.update_attributes(params[:interval])
        format.html { redirect_to action: "index", notice: 'Interval was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interval = Interval.find(params[:id])
    @interval.destroy

    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.json { head :no_content }
    end
  end
end
