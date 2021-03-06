class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user

  def spotify
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'spotify') if is_navigational_format?
    else
      session['devise.user_attributes'] = request.env['omniauth.auth']
      redirect_to new_user_session_url
    end
  end

  def failure
    flash[:alert] = 'Something went wrong'
    redirect_back_or_default
  end

  def set_user
    @user = User.from_omniauth(request.env['omniauth.auth'])
  end
end
