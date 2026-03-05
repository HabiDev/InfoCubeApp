class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_setting, only: [:edit, :update, :destroy]

  def index
    @settings = Setting.unscoped.order(:var)
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      Setting.clear_cache
      flash.now[:notice] = t('notice.record_create')
      respond_to(&:turbo_stream)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def new
    @setting = Setting.new
  end
  
  def edit; end

  def update
    if @setting.update(setting_params)
      Setting.clear_cache
      flash.now[:notice] = t('notice.record_edit')
      respond_to(&:turbo_stream)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_setting
    @setting = Setting.unscoped.find(params[:id])
  end

  def setting_params
    params.require(:setting).permit(:var, :value, :description)
  end
end