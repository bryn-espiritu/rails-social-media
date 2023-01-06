class OmniauthController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in :user, @user
      redirect_to posts_path
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      flash[:alert] = "There was a Problem signing you through Facebook. Please Try Again Later."
      redirect_to new_user_registration_path
    end
  end

  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      flash[:error] = "There was a Problem signing you through Github. Please Try Again Later."
      redirect_to new_user_registration_path
    end
  end

  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in :user, @user
      redirect_to posts_path
      flash[:notice] = "Login successfully"

    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a Problem signing you in. Please Try Again Later.'
    redirect_to new_user_registration_path
  end
end
