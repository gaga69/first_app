class RegistrationsController < Devise::RegistrationsController

    def after_sign_up_path_for(resource)
        user_path(resource)
    end

    def after_sign_out_path_for(resource)
        new_user_session_path
    end

    private
        def sign_up_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def account_update_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
        end

end

