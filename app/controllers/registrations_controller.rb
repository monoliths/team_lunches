class RegistrationsController < Devise::RegistrationsController
  private
    def sign_up_params
      params.require(:user).permit(:email, :password, :city)
    end

    def accounts_update_params
      params.require(:user).permit(:email, :password, :city, :current_password)
    end
end
