class SessionsController < ApplicationController
  before_action :check_state, only: %i(callback)

  def login
    login_state = SecureRandom.uuid
    session[:login_state] = login_state
    session[:original_url] = request.referer

    # TODO: 画面作るの面倒だから飛ばしちゃう
    redirect_to "/auth/facebook?login_state=#{login_state}"
  end

  def callback
    auth = request.env['omniauth.auth']
    other_service_account = OtherServiceAccount.find_or_initialize_by(provider: params[:provider], uid: auth[:uid])

    # アクセストークンチェック
    access_token = auth['credentials']['token']
    unless FacebookClient.new.valid_access_token?(access_token)
      redirect_to root_path
    end

    if other_service_account.persisted?
      user = User.find(other_service_account.user_id)
    else
      user = User.create!(
        name: auth[:info][:name], # Facebookの場合
        profile_image_url: auth[:info][:image]
      )
      other_service_account.user_id = user.id
      other_service_account.save!
    end

    redirect_url = session.delete(:original_url) || root_path

    reset_session

    session[:user_id] = user.id

    redirect_to redirect_url
  end

  private

  def check_state
    redirect_to root_path unless session[:login_state] == request.env['omniauth.params']['login_state']
  end
end
