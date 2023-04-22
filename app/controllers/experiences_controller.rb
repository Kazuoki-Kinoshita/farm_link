class ExperiencesController < ApplicationController
  load_and_authorize_resource
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  
  def index
    @experiences = current_user.farmer.experiences.includes(:plots).created_at_sorted
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
      redirect_to @experience, notice: "体験情報が保存されました。次は体験スケジュールを入れてください！"
    else
      @plots = current_user.farmer.plots
      render :new
    end
  end

  def edit
    @plots = current_user.farmer.plots
    @schedules = @experience.schedules
  end

  def update
    if @experience.update(experience_params)
      redirect_to experience_path(@experience), notice: "体験情報が更新されました。"
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
end