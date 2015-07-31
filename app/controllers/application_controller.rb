class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

   def current_ability

    if user_signed_in?
      @current_ability ||= ::UserAbility.new(current_user)
    else owner_signed_in?
      @current_ability ||= ::OwnerAbility.new(current_owner)
    end

  end

  # def current_ability
  #   @current_ability ||= case
  #                        when current_owner
  #                          OwnerAbility.new(current_owner)
  #                        else
  #                          UserAbility.new(current_user)
  #                        end
  # end

  protected

    # def configure_permitted_parameters_user
    #   devise_parameter_sanitizer.for(:sign_up) << :name
    #   devise_parameter_sanitizer.for(:account_update) << :name
    # end

    # def configure_permitted_parameters_owner

    #     devise_parameter_sanitizer.for(:sign_up) do |u|
    #       u.permit(:name, :email, :password,
    #         :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
    #         :remote_avatar_url)
    #     end

    #     devise_parameter_sanitizer.for(:account_update) do |u|
    #       u.permit(:name, :email, :password,
    #         :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
    #         :remote_avatar_url)
    #     end
    # end

    def configure_permitted_parameters
      if params[:controller] == "user"
        devise_parameter_sanitizer.for(:sign_up) << :name
        devise_parameter_sanitizer.for(:account_update) << :name
      else
        # devise_parameter_sanitizer.for(:sign_up) do |u|
        #   u.permit(:name, :rut, :phone, :role, :email, :password,
        #     :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
        #     :remote_avatar_url)
        # end
        # devise_parameter_sanitizer.for(:account_update) do |u|
        #   u.permit(:name, :rut, :phone, :role, :email, :password,
        #     :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
        #     :remote_avatar_url)
        # end
        devise_parameter_sanitizer.for(:sign_up) << :name << :rut << :phone << :role
        devise_parameter_sanitizer.for(:account_update) << :name << :rut << :phone << :role
      end

    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, alert: exception.message
    end

    # def configure_permitted_parameters
    #     devise_parameter_sanitizer.for(:sign_up) << :name

    #     devise_parameter_sanitizer.for(:account_update) do |u|
    #       u.permit(:name, :email, :password,
    #         :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
    #         :remote_avatar_url)
    #     end
    # end
end