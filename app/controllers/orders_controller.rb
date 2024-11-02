class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # authorize Division
    if current_user.admin? || current_user.moderator?
      @q = Order.ransack(params[:q])
    else
      @q = Order.current_divisions(current_user.divisions.pluck(:store_id)).ransack(params[:q])
    end
    @q.sorts = ['store asc' ] if @q.sorts.empty?
    @count_orders = @q.result.count
    @pagy, @orders = pagy(@q.result(disinct: true), items: 15)
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