class FacebookClient
  def valid_access_token?(access_token)
    result = client.debug_token(access_token)

    # 結果チェック
    unless result['data']['is_valid']
      return false
    end

    # アプリIDをチェック
    unless result['data']['app_id'].to_i == client_key
      return false
    end

    true
  end

  private

  def client
    @client ||= Koala::Facebook::API.new(app_access_token, client_secret)
  end

  def client_key
    Rails.application.secrets.facebook['app_id']
  end

  def client_secret
    Rails.application.secrets.facebook['app_secret']
  end

  def app_access_token
    @app_access_token ||= Koala::Facebook::OAuth.new(client_key, client_secret).get_app_access_token
  end

end
