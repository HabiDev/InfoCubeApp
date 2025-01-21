class FrovsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_frovs, only: [ :index ]
  
  def index   
    # # authorize Division 
    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'frovs', template: 'frovs/export_xls'
      end
    end
  end

  def import
    if params[:file].present?
      Frov.delete_all
      Frov.import(params[:file])
      
      flash.now[:notice] = t('notice.record_imported')
      set_frovs
    else
      flash.now[:error] = t('notice.record_imported_error')
    end
    # redirect_to orders_path unless turbo_frame_request?
  end

  def import_file; end

  def set_frovs
    if current_user.admin? || current_user.moderator?
      @q = Frov.includes(:division).ransack(params[:q])
      @frov_divisions = Division.all
    else
      @q = Frov.includes(:division).current_divisions(current_user.divisions.pluck(:id)).ransack(params[:q])
      @frov_divisions = current_user.divisions
    end
    @frovs = @q.result.provider
    @frov_products = @q.result.product
    @frov_product_groups = @q.result.product_group
    # @availability_order_coolings = @q.result.availability_order
    @to_order_frovs = @q.result.to_order
    @count_frovs = @q.result.count
    # @xls = @q.result(disinct: true)
    @q.sorts = ['division_name asc', 'provider asc', 'product asc'] if @q.sorts.empty?
    @xls = @q.result(disinct: true)
    @pagy, @frovs = pagy(@q.result(disinct: true), limit: 25)
  end
end