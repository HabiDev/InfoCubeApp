module OrderBkksHelper
  def oder_text(order)
    if order.present? && order > 0 
      return order
    else
      return "+"
    end
  end

  def order_bkk_cell_classing(order)
    content_tag(:i, '', class: "bi bi-check2-all fw-bold text-success") if order.present? && order > 0
  end

end