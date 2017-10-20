class ApplicationController < ActionController::Base
  include TreatSession

  protect_from_forgery with: :exception


  def hello
    render html:"Hello,World"
  end
end
