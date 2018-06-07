class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :require_login

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  def render_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render template: "errors/error_404", status: 404, layout: 'application'
  end

  def render_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render template: "errors/error_500", status: 500, layout: 'application'
  end

  def ensure_admin_user
    unless current_user.super
      flash[:error] = t('flash.no_authority')
      redirect_to tasks_path
    end
  end

  def current_user
    User.find(session[:user_id])
  end

private

  def require_login
    redirect_to login_path unless logged_in?
  end
end
