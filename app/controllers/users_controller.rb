# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :ensure_admin_user, only: %i[index update show destroy]
  skip_before_action :require_login, only: %i[new create]

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      flash[:error] = 'ユーザ登録に失敗しました'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_tasks = @user.tasks.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def my_groups
    @my_gu = current_user.group_users.order('group_id')
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :password_confirmation,
      :image
    )
  end
end
