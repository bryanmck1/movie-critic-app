class RegistrationsController < Devise::RegistrationsController

    def profile 
      self.resource = current_user      
      render 'devise/registrations/profile' 
    end

    protected

    def after_update_path_for(resource)
      if update_password?(resource)
        flash[:notice] = "Password successfully updated"
      else
        flash[:notice] = "Profile information successfully updated"
      end

      user_path(resource)
    end

    private 

    def update_password?(resource)
      resource.previous_changes.include?('encrypted_password')
    end

    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :current_password)}
    end
end
