class Frov < ApplicationRecord
  belongs_to :division, class_name: "Division", foreign_key: "store_id", optional: true

  default_scope { joins(:division).order(name: :asc, provider: :asc, product_group: :asc, product: :asc) }

  scope :provider, -> { where.not(provider: nil).reorder(:provider).distinct.pluck(:provider) }
  scope :product_group, -> { where.not(product_group: nil).reorder(:product_group).distinct.pluck(:product_group) }
  scope :product, -> { where.not(product: nil).reorder(:product).distinct.pluck(:product) }
  # scope :availability_order, -> { where.not(availability_order: nil).reorder(:availability_order).distinct.pluck(:availability_order) }
  scope :to_order, -> { where.not(to_order: nil).reorder(:to_order).distinct.pluck(:to_order) }

  scope :current_divisions, ->(divisions_ids) { where(store_id: divisions_ids)}

  def self.ransackable_attributes(auth_object = nil)

    [ "created_at", "day_store", "id", "product", "product_group", "product_id", "provider", "remainder",  
      "sales_two_week", "store_id", "to_order", "product_ways", "colored", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["division"]
  end

  def self.import(file)
    accessible_attributes = [ 'provider', 'product_group', 'store_id', 'product_id', 'product', 
                              'day_store', 'sales_two_week','product_ways', 'remainder', 'to_order', 'colored']

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      order_cooling = new
      order_cooling.attributes = row.to_hash.slice(*accessible_attributes)
      order_cooling.save
    end
  end
end
