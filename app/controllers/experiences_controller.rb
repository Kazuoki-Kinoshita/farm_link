class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_farmer, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @experiences = current_user.farmer.experiences.includes(:plots)
  end

  def show
    @plots = @experience.plots
  end

  def new
    @experience = Experience.new
    @plots = current_user.farmer.plots
  end

  def create
    @experience = current_user.farmer.experiences.build(experience_params)
    if @experience.save
      redirect_to @experience, notice: "体験情報が保存されました。"
    else
      render :new
    end
  end

  def edit
    @plots = current_user.farmer.plots
  end

  def update
    if @experience.update(experience_params)
      redirect_to @experience, notice: "体験情報が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @experience.destroy
    redirect_to experiences_url, notice: "体験情報が削除されました。"
  end

  
  private

  def experience_params
    params.require(:experience).permit(:title, :content, images: [], plot_ids: [])
  end

  def set_experience
    @experience = Experience.find(params[:id])
  end

  def redirect_unless_farmer
    if current_user.nil? || current_user.general?
      redirect_to root_path, alert: 'アクセス権限がありません。'
    elsif current_user.farmer.nil?
      redirect_to new_farmer_path, alert: 'まずはプロフィール登録をしてください。'
    end
  end
end