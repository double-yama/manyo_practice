module SessionsHelper


  def logged_in?
    !session[:user_id].nil?
  end

  def login user
    session[:user_id] = user.id
  end

  def current_user
    @user_memo || User.find(session[:user_id])
  end

  def logout
    session.delete :user_id
  end

  # ユーザモデルに書く
  # def super_user?
  #   current_user.super?
  # end
end
