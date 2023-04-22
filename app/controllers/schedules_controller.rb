class SchedulesController < ApplicationController
  load_and_authorize_resource :experience
  load_and_authorize_resource :schedule, through: :experience, except: :create
  before_action :set_experience, only: [:create, :edit, :update, :destroy]
  before_action :set_schedule, only: [:edit, :update, :destroy]

  def create
    @schedule = @experience.schedules.build(schedule_params)
    authorize! :create, @schedule
    
    if @schedule.save
      redirect_to @experience, notice: "スケジュールが追加されました。"
    else
      render 'experiences/show'
    end
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to @experience, notice: "スケジュールが更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    redirect_to @experience, notice: "スケジュールが削除されました。"
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :start_time, :end_time)
  end

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end

  def set_schedule
    @schedule = @experience.schedules.find(params[:id])
  end
end