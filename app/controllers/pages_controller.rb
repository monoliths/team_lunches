class PagesController < ApplicationController
  before_action :logged_in?, only: [:dashboard]

  def home
    redirect_to dashboard_path if current_user
  end

  def dashboard
  end

private
	def logged_in?
		unless current_user
			flash[:notice] = "Please login or signup!"
			redirect_to root_path and return
		end
	end
end
