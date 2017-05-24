class Admin::Renter < ApplicationRecord
  belongs_to :user

  has_many :agreement_renters, dependent: :destroy
  has_many :agreements, through: :agreement_renter

  validates :name, presence: true, length: { maximum: 255 }
  validates :identity_card, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :email, email: true
  validates :phone, phone: true

  validates :parent_phone, phone: true

  def self.search(search)
    search ? where("code LIKE ?", "%#{search[:code]}%") : all
  end

  after_create :update_code

  # TODO: Kiểm tra trạng thái đang ở hay không, dựa vào thông tin hợp đồng còn hiệu lực hay là không. 0 - Không, 1- Đang ở hoặc chỉ cần hiển thị phòng nếu đang ở.
  def available_status
    0
  end

  scope :user_scope, lambda { |user|
    Admin::Renter.where(user_id: user.id)
  }



  private

  def update_code
    self.update_column(:code, generate_code(Admin::Constants::AutoGenerateCode::RENTER, self.id)) # This will skip validation gracefully.
  end
end
