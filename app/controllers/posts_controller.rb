class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_farmer, only: [:index, :new, :create, :edit, :update, :destroy]
 
  def index
    @posts = current_user.farmer.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.farmer.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "投稿が保存されました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "投稿が削除されました。"
  end

  
  private

  def post_params
    params.require(:post).permit(:title, :content, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def redirect_unless_farmer
    if current_user.nil? || current_user.general?
      redirect_to root_path, alert: 'アクセス権限がありません。'
    elsif current_user.farmer.nil?
      redirect_to new_farmer_path, alert: 'まずはプロフィール登録をしてください。'
    end
  end
end