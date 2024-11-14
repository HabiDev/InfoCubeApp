class DivisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_division, except: [ :index, :new, :create, :import, :import_file ]
  before_action :set_divisions, only: [ :index ]

  def index; end

  def new
    # authorize Division
    @division = Division.new
  end

  def show; end

  def edit; end

  def create
    @division = Division.new(division_params) 
    # authorize @division  
    respond_to do |format|
      if @division.save
        format.html { redirect_to divisions_path, notice: t('notice.record_create') }
        format.turbo_stream { flash.now[:success] = t('notice.record_create') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    # authorize @division   
    respond_to do |format|
      if @division.update(division_params)
        format.html { redirect_to divisions_path, notice: t('notice.record_edit') }
        format.turbo_stream { flash.now[:warning] = t('notice.record_edit') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # authorize @division
    if @division.destroy
      respond_to do |format|
        format.html { redirect_to divisions_path, notice: t('notice.record_destroy') }
        format.turbo_stream { flash.now[:danger] = t('notice.record_destroy') }
      end
    else
      flash.now[:error] = t('notice.record_destroy_errors')
    end
  end

  def import
    if params[:file].present?
      Division.import(params[:file])
      set_divisions
      flash.now[:notice] = t('notice.record_imported')
    else
      flash.now[:error] = t('notice.record_imported_error')
    end
    redirect_to divisions_path unless turbo_frame_request?
  end

  def import_file; end

  private

  def set_division
    @division = Division.find(params[:id])
  end

  def set_divisions
    # authorize Division
    @q = Division.ransack(params[:q])
    @q.sorts = ['name asc' ] if @q.sorts.empty?
    # @divisions = @q.result(disinct: true)
    @pagy, @divisions = pagy(@q.result(disinct: true)) 
  end

  def division_params
    params.require(:division).permit(:store_id, :name, :organization)
  end
end