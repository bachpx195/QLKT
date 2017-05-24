class Admin::PaymentBill < ApplicationRecord
  belongs_to :user
  belongs_to :building

  delegate :name, :to => :user, :prefix => true, :allow_nil => true
  delegate :name, :to => :building, :prefix => true, :allow_nil => true

  validates :name, presence:true, length: { maximum: 255 }
  validates :payment_type, presence:true, length: { maximum: 255 }
  validates :unit, length: { maximum: 255 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :payment, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  after_create :update_code

  def self.search_by_building(search)
    if search!= nil
      Admin::Building.where(:building => "#{search[:building]}")
    else
      all
    end
  end

  def update_code
    self.update_column(:code, generate_code(Admin::Constants::AutoGenerateCode::PAYMENT_BILL, self.id)) # This will skip validation gracefully.
  end

end
