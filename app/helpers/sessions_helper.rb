module SessionsHelper


  def logged_in?
    !session[:user_id].nil?
  end

  def login user
    session[:user_id] = user.id
    $user_id = user.id
  end

  def logout
    session.delete :user_id
  end
end
