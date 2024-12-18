class Assortment < ApplicationRecord
  belongs_to :division, class_name: "Division", foreign_key: "store_id", optional: true

  default_scope { joins(:division).order(name: :asc, provider: :asc, product: :asc) }

  scope :provider, -> { where.not(provider: nil).reorder(:provider).distinct.pluck(:provider) }
  scope :product_group, -> { where.not(product_group: nil).reorder(:product_group).distinct.pluck(:product_group) }
  scope :product, -> { where.not(product: nil).reorder(:product).distinct.pluck(:product) }
  scope :remainder, -> { where.not(remainder: nil).reorder(:remainder).distinct.pluck(:remainder) }
  scope :comment, -> { where.not(comment: nil).reorder(:comment).distinct.pluck(:comment) }
  scope :sales, -> { where.not(sales: nil).reorder(:sales).distinct.pluck(:sales) }

  scope :current_divisions, ->(divisions_ids) { where(store_id: divisions_ids)}

  def self.ransackable_attributes(auth_object = nil)

    ['store_id', 'provider','product_group', 'product_id', 
      'product', 'comment', 'remainder','sales', "created_at", 
      "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["divisions"]
  end

  def self.import(file)
    accessible_attributes = [ 'store_id', 'product_group', 'provider', 'product_id', 
                              'product', 'comment', 'remainder','sales']

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      assortment = new
      assortment.attributes = row.to_hash.slice(*accessible_attributes)
      assortment.save
    end
  end
end
