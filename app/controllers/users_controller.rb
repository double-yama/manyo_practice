class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      redirect_to task_index_path, alert: 'ユーザー登録が完了しました'
    else
      render("users/new")
    end
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
