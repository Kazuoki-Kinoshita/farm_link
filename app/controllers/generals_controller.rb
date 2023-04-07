class GeneralsController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_general, only: [:show]
  # before_action :check_general_existence, only: [:new, :create] 

  def new
    @general = General.new
  end

  def create
    @general = General.new(general_params)
    @general.user = current_user
    if @general.save
      redirect_to user_general_path(@general.id), notice: "プロフィールが登録されました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def general_params
    params.require(:general).permit(:prefecture_id, :address)
  end

  # def check_general_existence
  #   if current_user.general.present?
  #     flash[:alart] = "既にプロフィールが登録されています"
  #     redirect_to  new_user_session_path
  #   end
  # end

  private
  def set_general
    @general = General.find_by(user_id: current_user.id)
  end
end
