module TreatSession
  extend ActiveSupport::Concern

  included do
    helper_method %i(
      login_user
      logged_in?
    )

    private

    def require_login
      redirect_to login_path unless logged_in?
    end

    def logged_in?
      login_user.present?
    end

    def login_user
      @login_user ||= User.find_by(id: login_user_id)
    end

    def login_user_id
      session[:user_id]
    end
  end
end
