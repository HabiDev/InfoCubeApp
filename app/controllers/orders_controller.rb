class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index   
    # authorize Division
    if current_user.admin? || current_user.moderator?
      @q = Order.ransack(params[:q])
      @order_divisions = Division.all
    else
      @q = Order.current_divisions(current_user.divisions.pluck(:id)).ransack(params[:q])
      @order_divisions = current_user.divisions
    end
    @order_providers = @q.result.provider
    @order_products = @q.result.product
    @order_product_groups = @q.result.product_group
    @availability_orders = @q.result.availability_order
    @to_orders = @q.result.to_order
    @count_orders = @q.result.count
    @xls = @q.result(disinct: true)
    @pagy, @orders = pagy(@q.result(disinct: true), limit: 25)
    
    @q.sorts = ['store asc' ] if @q.sorts.empty?

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
    else
      flash.now[:error] = t('notice.record_imported_error')
    end
    redirect_to orders_path unless turbo_frame_request?
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
end