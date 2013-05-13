class SchedulesController < ApplicationController
	respond_to :json

	def index
		respond_with Schedule.all
	end

	def show
		respond_with Schedule.find(params[:id])
	end

	def create
		respond_with Schedule.create(params[:id])
	end

	def update
		respond_with Schedule.update(params[:id], params[:schedule])
	end

	def destroy
		respond_with Schedule.destroy(params[:id])
	end
end
