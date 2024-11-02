class Profile < ApplicationRecord
  belongs_to :user
  
  validates :full_name, :mobile, presence: true

  default_scope { order(full_name: :asc) }


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "full_name", "mobile", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user" ]
  end
  
end
