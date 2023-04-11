class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_farmer, only: [:index, :new, :create, :edit, :update, :destroy]

  def new
    @experience = Experience.new
  end

  def create
    @experience = current_user.farmer.experiences.build(experience_params)
    if @experience.save
      redirect_to @experience, notice: "体験情報が保存されました。"
    else
      render :new
    end
  end

  def show
  end


  private

  def experience_params
    params.require(:experience).permit(:title, :content, images: [])
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