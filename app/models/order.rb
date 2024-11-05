class Order < ApplicationRecord
  belongs_to :division, class_name: "Division", foreign_key: "store_id", optional: true

  # default_scope { order(store: :asc) }

  scope :provider, -> { where.not(provider: nil).order(:provider).distinct.pluck(:provider) }
  scope :product_group, -> { where.not(product_group: nil).order(:product_group).distinct.pluck(:product_group) }
  scope :product, -> { where.not(product: nil).order(:product).distinct.pluck(:product) }
  scope :availability_order, -> { where.not(availability_order: nil).order(:availability_order).distinct.pluck(:availability_order) }

  scope :current_divisions, ->(divisions_ids) { where(store_id: divisions_ids)}

  def self.ransackable_attributes(auth_object = nil)

    ["availability_order", "average_sales", "cal_day_order", "created_at", 
      "day_store", "id", "next_order", "product", 
      "product_group", "provider", "quantum", "remainder", "required", 
      "sales", "store_id", "store", "to_order", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["divisions"]
  end

  def self.import(file)
    accessible_attributes = [ 'store_id', 'provider', 
                              'product_group', 'required', 'product', 'day_store', 'sales', 
                              'remainder', 'average_sales', 'to_order', 'quantum', 
                              'availability_order', 'next_order', 'cal_day_order']

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      order = new
      order.attributes = row.to_hash.slice(*accessible_attributes)
      order.save
    end
  end
  


end
