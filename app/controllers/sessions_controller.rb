class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = User.find_by(username: name_params["username"])
    if @user&.authenticate(password_params["password"])
      login @user
      redirect_to tasks_path
    else
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

private

  def name_params
    params.require(:session).permit(:username)
  end

  def password_params
    params.require(:session).permit(:password)
  end
end
