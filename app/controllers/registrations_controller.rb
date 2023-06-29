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

    rescue_from ActiveRecord::RecordNotUnique do |exception|
    if exception.message =~ /UNIQUE constraint failed: users.username/
      redirect_to new_user_registration_url, alert: 'Username has already been taken.'
    else
      # Handle other RecordNotUnique exceptions or fallback to default behavior
      super
    end
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
