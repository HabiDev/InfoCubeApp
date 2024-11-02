class Division < ApplicationRecord
  has_many :division, dependent: :destroy

  scope :except_user_divisions, ->(divisions_ids) { where.not(id: divisions_ids) }

  def self.ransackable_attributes(auth_object = nil)
    ["name", "store_id", "organization", "created_at", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end

  def self.import(file)
    accessible_attributes = ['store_id','name', 'organization']

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      division = find_by_store_id(row["store_id"]) || new
      division.attributes = row.to_hash.slice(*accessible_attributes)
      division.save
    end
  end
end
