class Admin::Service < ApplicationRecord
  belongs_to :user
  belongs_to :building

  has_many :agreement_service
  has_many :agreement, through: :agreement_service
  has_many :bill_detail, through: :agreement_service

  delegate :name, :to => :user, :prefix => true, :allow_nil => true
  delegate :name, :to => :building, :prefix => true, :allow_nil => true

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }
  validates :building, presence: true, length: { maximum: 255 }
  validates :unit, length: { maximum: 255 }
  validates :unit_price, length: { maximum: 255 }, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def self.find_by_building(building_id)
    building_id ? where(building_id: building_id) : where(id: 0)
  end

  def self.search(search)
    search ? where("name  LIKE ?", "%#{search[:name]}%") : all
  end
end
