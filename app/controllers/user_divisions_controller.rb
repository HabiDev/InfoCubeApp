class UserDivisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :new ]
  before_action :set_user_create, only: [ :create ]
  before_action :set_user_division, only: [ :destroy]
  

  def new
    # authorize User
    @user_division = @user.user_divisions.build
    @divisions_lists = Division.except_user_divisions(user_divisions.pluck(:division_id))
  end

  def create
    @user_division = @user.user_divisions.build(user_division_params)
    respond_to do |format|
      if  @user_division.save
        # format.html { redirect_to task_path(@task), notice: t('notice.record_create') }
        format.turbo_stream { flash.now[:success] = t('notice.record_create') }
      else
        format.html { render :new, status: :unprocessable_entity }
        @divisions_lists = Division.except_user_divisions(@user.user_divisions.pluck(:division_id))
      end
    end
  end

  def destroy   
    # authorize completed_task
    @user = @user_division.user
    if @user_division.destroy
      respond_to do |format|
        format.html { redirect_to mission_path(@mission), notice: t('notice.record_destroy') }
        format.turbo_stream { flash.now[:danger] = t('notice.record_destroy') }
      end
    else
      flash.now[:error] = t('notice.record_destroy_errors')
    end
  end

  private

  def set_user_create
    @user =  User.find(params[:user_division][:user_id])
  end

  def set_user
    @user =  User.find(params[:user_id])
  end

  def set_user_division
    @user_division =  UserDivision.find(params[:id])
  end

  def user_division_params
    params.require(:user_division).permit(:user_id, :division_id)
  end
end