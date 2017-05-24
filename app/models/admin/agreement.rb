class Admin::Agreement < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :owner, :class_name => "Admin::Renter", :foreign_key => "renter_id"

  has_many :bill, dependent: :destroy
  has_many :agreement_renter, dependent: :destroy
  has_many :renter, through: :agreement_renter, dependent: :destroy
  has_many :agreement_service, dependent: :destroy
  has_many :service, through: :agreement_service, dependent: :destroy

  after_create :update_code

  def to_label
    "#{code}"
  end

  def self.select_bill_by_agreement(month, year, user_id)
    # Lấy toàn bộ bill theo tháng, để lấy được họp toàn bộ số hợp đồng, sau đó lấy toàn bộ các hợp đồng có hiệu lực hoặc thuộc nhóm trên.
    select("agreements.*, IFNULL(b.year, #{year}) AS year, IFNULL(b.month, #{month}) AS month, b.id AS bill_id, b.code AS bill_code, b.status AS bill_status ").joins("
      LEFT OUTER JOIN (SELECT * FROM bills WHERE bills.month = #{month} AND bills.year = #{year} AND bills.user_id = #{user_id}) b ON b.agreement_id = agreements.id
      WHERE agreements.user_id = #{user_id} AND start_date <= '#{year}-#{month}-31' AND '#{year}-#{month}-01' <= end_date AND agreements.status <> #{Admin::Constants::AGREEMENT_STATUS_INVALID} OR agreements.id IN (SELECT DISTINCT agreements.id FROM agreements INNER JOIN (SELECT * FROM bills WHERE bills.month = #{month} AND bills.year = #{year} AND bills.user_id = #{user_id}) b ON b.agreement_id = agreements.id
      WHERE agreements.user_id = #{user_id})")
  end
  # tim kiem agreement theo month/year, building_id,room_id,owner_name,identity_card, paid
  def self.select_bill_by_agreement_demo(month, year,building_id,room_id,owner_name,identity_card,paid, user_id)
    buildingStr = ""
    ownerNameStr = ""
    identityCardStr = ""
    # mặc định chọn tất agreement: đã thanh toán + chưa thanh toán
    paidStr = "OR agreements.id IN (SELECT DISTINCT agreements.id FROM agreements INNER JOIN (SELECT * FROM bills WHERE bills.month = #{month} AND bills.year = #{year} AND bills.user_id = #{user_id}) b ON b.agreement_id = agreements.id"
    if building_id.to_i > 0
      buildingStr = "AND agreements.room_id IN (SELECT id FROM rooms WHERE building_id = #{building_id})"
    end

    if room_id.to_i > 0
      buildingStr = buildingStr[0..-2] + " AND rooms.id = #{room_id})"
    end

    if owner_name != "" && identity_card != ""
      ownerNameStr = "INNER JOIN (SELECT agreement_renters.agreement_id FROM agreement_renters where agreement_renters.renter_id IN (SELECT renters.id FROM renters WHERE name LIKE '%#{owner_name}%' AND identity_card LIKE '%#{identity_card}%')) c ON c.agreement_id = agreements.id"
    elsif owner_name != ""
      ownerNameStr = "INNER JOIN (SELECT agreement_renters.agreement_id FROM agreement_renters where agreement_renters.renter_id IN (SELECT renters.id FROM renters WHERE name LIKE '%#{owner_name}%')) c ON c.agreement_id = agreements.id"
    elsif owner_name != ""
      ownerNameStr = "INNER JOIN (SELECT agreement_renters.agreement_id FROM agreement_renters where agreement_renters.renter_id IN (SELECT renters.id FROM renters WHERE identity_card LIKE '%#{identity_card}%')) c ON c.agreement_id = agreements.id"
    end

    if paid.to_i == Admin::Constants::BILL_PAID  || paid.to_i == Admin::Constants::BILL_NOT_PAID# tìm tất cả agreement đã thanh toán
      paidStr = "AND agreements.id IN (SELECT DISTINCT agreements.id FROM agreements INNER JOIN (SELECT * FROM bills WHERE bills.month = #{month} AND bills.year = #{year} AND bills.user_id = #{user_id} AND bills.status = #{paid}) b ON b.agreement_id = agreements.id"
    end

    select("agreements.*, IFNULL(b.year, #{year}) AS year, IFNULL(b.month, #{month}) AS month, b.id AS bill_id, b.code AS bill_code, b.status AS bill_status ").joins("
      LEFT OUTER JOIN (SELECT * FROM bills WHERE bills.month = #{month} AND bills.year = #{year} AND bills.user_id = #{user_id}) b ON b.agreement_id = agreements.id
      #{ownerNameStr} #{identityCardStr}
      WHERE agreements.user_id = #{user_id} AND start_date <= '#{year}-#{month}-31' AND agreements.status = #{Admin::Constants::AGREEMENT_STATUS_VALID} #{buildingStr} #{paidStr}
      WHERE agreements.user_id = #{user_id} #{buildingStr})")
  end

  def self.search_by_room(admin_rooms)
    if !admin_rooms.nil? || admin_rooms.count() != 0
      where(:room_id => admin_rooms.map(&:id))
    else
      all
    end
  end

  def self.search_by_code(search)
    search ? where("code  LIKE ?", "%#{search[:code]}%") : all
  end

  def self.search_by_bulding(search)
    if !search[:building].blank?
      where(:room_id => search[:room].map(&:id))
    else
      all
    end
  end

  def self.search_by_room1(search)
    if !search[:room].blank?
      where(:room_id => "#{search[:room]}")
    else
      all
    end
  end

  def self.search_by_status(search)
    if !search[:status].blank?
      where(:status => search[:status])
    else
      all
    end
  end

  def self.search_by_renter(search)
    if !search[:room].blank?
      where(:room_id => "#{search[:room]}")
    else
      all
    end
  end

  def update_code
    self.update_column(:code, generate_code(Admin::Constants::AutoGenerateCode::AGREEMENT, self.id)) # This will skip validation gracefully.
  end
end
