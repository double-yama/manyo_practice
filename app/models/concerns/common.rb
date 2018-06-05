module Common
  extend ActiveSupport::Concern
    def current_user
      User.find(session[:user_id])
    end

end