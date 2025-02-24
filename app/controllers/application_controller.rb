class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user = User.find_by(id: cookies.signed[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    current_user&.admin?
  end

  def require_admin
    unless admin?
      render "errors/forbidden", status: 403
    end
  end

  def require_login
    redirect_to new_session_path unless logged_in?
  end
end
