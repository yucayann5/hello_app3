Rails.application.config.middleware.use OmniAuth::Builder do
  secrets = Rails.application.secrets
  provider :facebook, secrets.facebook['app_id'], secrets.facebook['app_secret']
end
