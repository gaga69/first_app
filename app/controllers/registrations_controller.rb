class RegistrationsController < Devise::RegistrationsController
  
    private
        def sign_up_params
            params.requier(:user).permit(:name, :email, :password, :password_confirmation)
        end

end

