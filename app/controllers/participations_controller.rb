class ParticipationsController < ApplicationController

	def new
		@participation = Participation.new
	end

	def create
		@user = current_user
		@user.groups << Group.find(params[:group_id])
	end

	def destroy

	end

end
