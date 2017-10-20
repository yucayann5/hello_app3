class TrustsController < ApplicationController
  include TreatUser

  def index
    @user_trusts = UserTrust.where(user_id: current_user.id).order(updated_at: :desc).to_a
  end

  def show
    @user_trust = UserTrust.find_by!(id: params[:id], user_id: current_user.id)
  end

  def new
    @user_trust = UserTrust.new(user_id: current_user.id, from_user_id: login_user.id)
  end

  def create
    @user_trust = UserTrust.new(new_attributes)
    @user_trust.user_id = current_user.id
    @user_trust.from_user_id = login_user.id

    if @user_trust.invalid?
      return render :new
    end

    begin
      UserTrust.transaction do
        @user_trust.save!
      end
    rescue => e
      logger.error(e.message)
      return redirect_to user_trusts_path(current_user)
    end

    flash[:notice] = 'TRUSTを投稿しました！'
    redirect_to user_trusts_path(current_user)
  end

  def edit
    @user_trust = UserTrust.find_by!(id: params[:id], user_id: current_user.id)
  end

  def update
    @user_trust = UserTrust.find_by!(id: params[:id], user_id: current_user.id)
    @user_trust.attributes = edit_attributes

    if @user_trust.invalid?
      return render :edit
    end

    begin
      UserTrust.transaction do
        @user_trust.save!
      end
    rescue => e
      logger.error(e.message)
      return redirect_to user_trusts_path(current_user)
    end

    flash[:notice] = 'TRUSTを更新しました！'
    redirect_to user_trusts_path(current_user)
  end

  def destroy
    user_trust = UserTrust.find_by!(id: params[:id], user_id: current_user.id)
    user_trust.destroy!

    flash[:notice] = 'TRUSTを削除しました'
    redirect_to user_trusts_path(current_user)
  end

  private

  def new_attributes
    params.require(:user_trust).permit(:content)
  end

  def edit_attributes
    params.require(:user_trust).permit(:content)
  end
end
