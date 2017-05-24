class Admin::RoomDevice < ApplicationRecord
  belongs_to :user
  belongs_to :room
  delegate :name, :to => :user, :prefix => true, :allow_nil => true
  delegate :name, :to => :room, :prefix => true, :allow_nil => true
  validates :name, presence:true, length: { maximum: 255 }
  validates :amount, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  def self.search(search)
    search ? where("name  LIKE ?", "%#{search[:name]}%") : all
  end
end
