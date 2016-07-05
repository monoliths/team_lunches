class PagesController < ApplicationController
  def home
    redirect_to dashboard_path if current_user
  end

  def dashboard
  end

end
