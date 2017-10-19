class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :desc)
  end
end
