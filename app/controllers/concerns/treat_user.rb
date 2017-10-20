module TreatUser
  extend ActiveSupport::Concern

  included do
    helper_method %i(
      current_user
    )

    private

    def current_user
      @user ||= User.find(params[:user_id])
    end
  end
end
