class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def friendly_updated_at
    updated_at.strftime("%I:%M:%S %p")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def japan_phone_number
    "+81 #{phone_number}"
  end

end