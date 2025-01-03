class OrderCoolingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_coolings, only: [ :index ]
  
  def index   
    # # authorize Division 
    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'order_coolings', template: 'order_coolings/export_xls'
      end
    end
  end

  def import
    if params[:file].present?
      OrderCooling.delete_all
      OrderCooling.import(params[:file])
      
      flash.now[:notice] = t('notice.record_imported')
      set_order_coolings
    else
      flash.now[:error] = t('notice.record_imported_error')
    end
    # redirect_to orders_path unless turbo_frame_request?
  end

  def import_file; end

  def set_order_coolings
    if current_user.admin? || current_user.moderator?
      @q = OrderCooling.includes(:division).ransack(params[:q])
      @order_cooling_divisions = Division.all
    else
      @q = OrderCooling.includes(:division).current_divisions(current_user.divisions.pluck(:id)).ransack(params[:q])
      @order_cooling_divisions = current_user.divisions
    end
    @order_cooling_providers = @q.result.provider
    @order_cooling_products = @q.result.product
    @oorder_cooling_product_groups = @q.result.product_group
    @availability_order_coolings = @q.result.availability_order
    @to_order_coolings = @q.result.to_order
    @count_order_coolings = @q.result.count
    # @xls = @q.result(disinct: true)
    @q.sorts = ['division_name asc', 'provider asc', 'product asc'] if @q.sorts.empty?
    @xls = @q.result(disinct: true)
    @pagy, @order_coolings = pagy(@q.result(disinct: true), limit: 25)
  end
end