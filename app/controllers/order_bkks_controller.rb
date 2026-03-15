class OrderBkksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_bkks, only: [ :index ]
  before_action :set_order_bkk, only: [ :edit, :update ]
  before_action :check_edit_time, only: [:update]
  
  def index   
    # # authorize Division 
    respond_to do |format|
      format.html
      format.turbo_stream
      format.xlsx do
        render xlsx: 'order_bkks', template: 'order_bkks/export_xls'
      end
    end
  end
  
  def edit; end

  def show; end
  
  def update
    # authorize @card  

    respond_to do |format|
      if @order_bkk.update(order_bkk_params)
        format.html { redirect_to order_bkks_path, notice: t('notice.record_edit') }
        format.turbo_stream { flash.now[:notice] = t('notice.record_edit') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def import
    if params[:file].present?
      OrderBkk.delete_all
      OrderBkk.import(params[:file])
      redirect_to order_bkks_path, notice: t('notice.record_imported')
    else
      redirect_to order_bkks_path, alert: t('notice.record_imported_error')
    end
  end

  def import_file; end

  def set_order_bkks
    if current_user.admin? || current_user.moderator? || current_user.guide?
      @q = OrderBkk.includes(:division).ransack(params[:q])
      @order_bkk_divisions = Division.all
    else
      @q = OrderBkk.includes(:division).current_divisions(current_user.divisions.pluck(:id)).ransack(params[:q])
      @order_bkk_divisions = current_user.divisions
    end
    # @order_bkks = @q.result
    @order_bkk_products = @q.result.product
    @order_bkk_product_groups = @q.result.product_group
    @order_bkk_product_categories = @q.result.product_category
    # @availability_order_coolings = @q.result.availability_order
    # @to_order_frovs = @q.result.to_order
    @count_order_bkks = @q.result.count
    # @xls = @q.result(disinct: true)
    @q.sorts = ['division_name asc', 'product_category asc', 'product asc'] if @q.sorts.empty?
    @xls = @q.result(disinct: true)
    @pagy, @order_bkks = pagy(@q.result(distinct: true).includes(:division))
  end

  private

  def check_edit_time
    return unless Time.current.hour >= Setting.val('limit_time_order_bkk').to_i

    respond_to do |format|
      format.turbo_stream do
        flash.now[:warning] = t('notice.order_bkk_warning')
        render turbo_stream: turbo_stream.prepend("flash", partial: "shared/flash")
      end

      format.html do
        redirect_to order_bkks_path, alert: t('notice.order_bkk_warning')
      end
    end

    return
  end


  def set_order_bkk
    @order_bkk = OrderBkk.find(params[:id])    
  end

  def order_bkk_params
    params.require(:order_bkk).permit(:order, :additional_order)
  end
end