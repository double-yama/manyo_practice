class LoginController < ApplicationController
  def index

  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password_digest))
    if @task.save
      redirect_to task_index_path
    else
      render new_task_path
    end
  end

  def new
    @user = User.new
  end

  def destroy
  end

  def login
    @login_info = User.find(params[:email])
  end
end
