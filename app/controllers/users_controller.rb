class UsersController < ApplicationController
  before_action :ensure_correct_user, only: %i[index destroy]
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
      render("users/new")
    end
  end

  def show
    @users_tasks = Task::my_task(params[:id])
    @user_name = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    Task::destroy_all_tasks(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def ensure_correct_user
    redirect_to tasks_path, flash[:notice] = t('flash.no_authority') unless current_user.super
  end

private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :image)
  end
end
