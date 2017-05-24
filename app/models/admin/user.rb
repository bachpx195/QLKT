class Admin::User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group

  has_many :agreement
  has_many :agreement_renter
  has_many :agreement_service
  has_many :bill
  has_many :bill_detail
  has_many :building
  has_many :config
  has_many :electricity_water
  has_many :feedback
  has_many :payment_bill
  has_many :renter
  has_many :room
  has_many :room_device
  has_many :service
end
