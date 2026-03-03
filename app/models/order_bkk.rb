class OrderBkk < ApplicationRecord
  belongs_to :division, class_name: "Division", foreign_key: "store_id", optional: true

  default_scope { joins(:division).order(name: :asc, product: :asc) }

  # scope :provider, -> { where.not(provider: nil).reorder(:provider).distinct.pluck(:provider) }
  # scope :product_group, -> { where.not(product_group: nil).reorder(:product_group).distinct.pluck(:product_group) }
  scope :product, -> { where.not(product: nil).reorder(:product).distinct.pluck(:product) }
  # scope :availability_order, -> { where.not(availability_order: nil).reorder(:availability_order).distinct.pluck(:availability_order) }
  # scope :order, -> { where.not(to_order: nil).reorder(:to_order).distinct.pluck(:to_order) }

  scope :current_divisions, ->(divisions_ids) { where(store_id: divisions_ids)}

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "store_manager", "product", "product_id", "average_sales", "remainder",  
      "sales_four_weeks_ago",	"sales_three_weeks_ago", "sales_two_weeks_ago",	"sales_one_weeks_ago", 
      "store_id", "recommended_order", "order", "colored", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["division"]
  end

  def self.import(file)
    accessible_attributes = [ 'store_manager', 'store_id', 'store_id', 'product_id', 'product', 
                              'sales_four_weeks_ago', 'sales_three_weeks_ago', 'sales_two_weeks_ago', 'sales_one_weeks_ago',
                              'average_sales', 'remainder', 'recommended_order', 'order', 'colored']

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      order_bkk = new
      order_bkk.attributes = row.to_hash.slice(*accessible_attributes)
      order_bkk.save
    end
  end
end
