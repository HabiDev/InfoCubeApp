class AssortmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assortments, only: [ :index ]
  def index   
    # authorize Division
    # if current_user.admin? || current_user.moderator?
    #   @q = Assortment.ransack(params[:q])
    #   @assortment_divisions = Division.all
    # else
    #   @q = Assortment.current_divisions(current_user.divisions.pluck(:id)).ransack(params[:q])
    #   @assortment_divisions = current_user.divisions
    # end
    # @assortment_providers = @q.result.provider
    # @assortment_products = @q.result.product
    # @assortment_product_groups = @q.result.product_group
    # @assortment_remainder = @q.result.remainder
    # @assortment_sales = @q.result.sales
    # @assortment_comment = @q.result.comment
    # @count_assortments = @q.result.count
    # # @xls = @q.result(disinct: true)
    # @pagy, @assortments = pagy(@q.result(disinct: true), limit: 25)
    
    # @q.sorts = ['store asc' ] if @q.sorts.empty?

    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'assortments', template: 'assortments/export_xls'
      end
    end
  end

  def import
    if params[:file].present?
      Assortment.delete_all
      Assortment.import(params[:file])
      set_assortments
      flash.now[:notice] = t('notice.record_imported')
    else
      flash.now[:error] = t('notice.record_imported_error')
    end
    # redirect_to assortments_path unless turbo_frame_request?
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

  def set_assortments
    if current_user.admin? || current_user.moderator? || current_user.guide?
      @q = Assortment.includes(:division).ransack(params[:q])
      @assortment_divisions = Division.all
    else
      @q = Assortment.includes(:division).current_divisions(current_user.divisions.pluck(:id)).ransack(params[:q])
      @assortment_divisions = current_user.divisions
    end
    @assortment_providers = @q.result.provider
    @assortment_products = @q.result.product
    @assortment_product_groups = @q.result.product_group
    @assortment_remainder = @q.result.remainder
    @assortment_sales = @q.result.sales
    @assortment_comment = @q.result.comment
    @count_assortments = @q.result.count
    @xls = @q.result(disinct: true)
    @q.sorts = ['division_name asc', 'provider asc', 'product asc'] if @q.sorts.empty?
    @pagy, @assortments = pagy(@q.result(disinct: true), limit: 25)

    
  end

end