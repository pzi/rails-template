class DeviseCustomisations::RegistrationsController < Devise::RegistrationsController

  def build_resource(args)
    super.tap do |user|
      user.role = User.roles["member"]
    end
  end

protected

  def account_update_params
    params.require(:user)
          .permit(valid_attributes)
          .merge(devise_parameter_sanitizer.sanitize(:account_update))
  end

  def after_update_path_for(resource)
    # after user edits their own profile, we redirect to the same place
    # user's get redirect when sign in (usually dashboard)
    after_sign_in_path_for(resource)
  end

  def sign_up_params
    params.require(:user)
          .permit(valid_attributes)
          .merge(devise_parameter_sanitizer.sanitize(:sign_up))
  end

  def valid_attributes
    [
      :given_names,
      :family_name,
    ]
  end

end
