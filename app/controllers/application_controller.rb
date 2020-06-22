class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: %i[top about]

  # ログイン後に遷移
  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = 'Signed in successfully.'
      # user_path(current_user.id)
      user_path(resource)
    else
      flash[:notice] = 'some error has occuered'
      root_path
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
      # devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    end
end
