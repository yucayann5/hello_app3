class TrustsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_trusts = UserTrust.where(user_id: @user.id).order(updated_at: :desc).to_a
  end

  def new
    @user = User.find(params[:user_id])
    @user_trust = UserTrust.new(user_id: @user.id, from_user_id: current_user.id)
    @message = get_message
  end

  def create
    @user = User.find(params[:user_id])
    @user_trust = UserTrust.new(new_attributes)
    @user_trust.user_id = @user.id
    @user_trust.from_user_id = current_user.id

    if @user_trust.invalid?
      @message = get_message
      return render :new
    end

    begin
      UserTrust.transaction do
        @user_trust.save!
      end
    rescue => e
      logger.error(e.message)
      return redirect_to user_trusts_path(@user)
    end

    flash[:notice] = "TRUSTを投稿しました！"
    redirect_to user_trusts_path(@user)
  end

  private

  def new_attributes
    params.require(:user_trust).permit(:content)
  end

  def get_message
    %W(
      #{@user.name}さんの強みは？
      #{@user.name}さんの性格は？
      #{@user.name}さんとの関係は？
      #{@user.name}さんの尊敬しているところは？
      #{@user.name}さんの弱みをしいてあげるなら？
      #{@user.name}さんは何をしているひと？
      #{@user.name}さんのスキルは？
      #{@user.name}さんをあなたが採用するなら、どんなポジションにしますか？
    ).sample
  end
end
