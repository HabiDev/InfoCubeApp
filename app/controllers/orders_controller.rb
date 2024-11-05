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
    @count_orders = @q.result.count    
    @pagy, @orders = pagy(@q.result(disinct: true))
    @q.sorts = ['store asc' ] if @q.sorts.empty?
  end

  def import
    if params[:file].present?
      Order.delete_all
      Order.import(params[:file])
      flash.now[:notice] = t('notice.record_imported')
    else
      flash.now[:error] = t('notice.record_imported_error')
    end
  end

  def import_file; end
end