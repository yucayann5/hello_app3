class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    name = "岩崎"
    messages = %W(
      #{name}さんの強みは？
      #{name}さんの性格は？
      #{name}さんとの関係は？
      #{name}さんの尊敬しているところは？
      #{name}さんの弱みをしいてあげるなら？
      #{name}さんは何をしているひと？
      #{name}さんのスキルは？
      #{name}さんをあなたが採用するなら、どんなポジションにしますか？
  )
    @message = messages.sample
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content])
    @post.save
    if @post.save
      flash[:notice] = "TRUSTを投稿しました！"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました！"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end



end
