class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      # login @user
      p 'huhuhuhuhuhuhuh'
      login @user
      redirect_to task_index_path
    else
      session[:username] = nil
      redirect_to login_path, alert: 'ログインできませんでした'
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
