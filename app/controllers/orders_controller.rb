class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_orders, only: [ :index ]
  
  def index   
    # # authorize Division 
    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'orders', template: 'orders/export_xls'
      end
    end
  end

  def import
    if params[:file].present?
      Order.delete_all
      Order.import(params[:file])
      
      flash.now[:notice] = t('notice.record_imported')
      set_orders
    else
      flash.now[:error] = t('notice.record_imported_error')
    end
    # redirect_to orders_path unless turbo_frame_request?
  end

  def import_file; end

  # def export_xls
  #   respond_to do |format|
  #     format.html
  #     format.xlsx do
  #       @orders = $xls
  #       render xlsx: 'orders', template: 'orders/export_xls'
  #     end
  #   end
  # end

  def set_orders
    if current_user.admin? || current_user.moderator? || current_user.guide?
      @q = Order.includes(:division).ransack(params[:q])
      @order_divisions = Division.all
    else
      @q = Order.includes(:division).current_divisions(current_user.divisions.pluck(:id)).ransack(params[:q])
      @order_divisions = current_user.divisions
    end
    @order_providers = @q.result.provider
    @order_products = @q.result.product
    @order_product_groups = @q.result.product_group
    @availability_orders = @q.result.availability_order
    @to_orders = @q.result.to_order
    @count_orders = @q.result.count
    # @xls = @q.result(disinct: true)
    @q.sorts = ['division_name asc', 'provider asc', 'product asc'] if @q.sorts.empty?
    @xls = @q.result(disinct: true)
    @pagy, @orders = pagy(@q.result(disinct: true), limit: 25)
  end
end