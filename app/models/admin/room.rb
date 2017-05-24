class Admin::Room < ApplicationRecord
  belongs_to :user
  belongs_to :building

  has_many :electricity_water, dependent: :destroy
  has_many :room_devices, dependent: :destroy
  has_many :agreement, dependent: :destroy

  validates :name, presence: true
  validates :cost, :numericality => { :greater_than_or_equal_to => 0 }
  validates :amount, :numericality => { :greater_than => 0 }

  def self.find_by_building(building_id , is_agreement = '0', last_room = '0')
    if is_agreement == '1'
      building_id ? where(building_id: building_id).where(status: Admin::Constants::ROOM_EMPTY).or(Admin::Room.where(id: last_room)) : where(id: 0)
    else
      building_id ? where(building_id: building_id) : where(id: 0)
    end
  end

  def self.select_electricity_waters(building_id, room_id, last_month, last_year, month, year, user_id)
    buildingStr = ""
    roomStr = ""
    if building_id.to_i > 0
      buildingStr = " AND buildings.id = #{building_id}"
      if room_id.to_i > 0
        roomStr = " AND rooms.id = #{room_id}"
      end
    end

    select("rooms.id AS room_id, rooms.name AS room_name, buildings.id AS building_id, buildings.parent_id AS building_parent_id, buildings.name AS building_name, IFNULL(b.year, #{year}) AS year, IFNULL(b.month, #{month}) AS month, IFNULL(b.start_electricity, IFNULL(a.end_electricity, 0)) AS start_electricity, IFNULL(b.end_electricity, 0) AS end_electricity, IFNULL(b.total_electricity, 0) AS total_electricity, IFNULL(b.start_water, IFNULL(a.end_water,0)) AS start_water, IFNULL(b.end_water, 0) AS end_water, IFNULL(b.total_water, 0) AS total_water").joins("INNER JOIN buildings ON buildings.id = rooms.building_id
      LEFT OUTER JOIN (SELECT * FROM electricity_waters WHERE electricity_waters.month = #{last_month} AND electricity_waters.year = #{last_year} AND electricity_waters.user_id = #{user_id}) a ON a.room_id = rooms.id
      LEFT OUTER JOIN (SELECT * FROM electricity_waters WHERE electricity_waters.month = #{month} AND electricity_waters.year = #{year} AND electricity_waters.user_id = #{user_id}) b ON b.room_id = rooms.id
      WHERE rooms.user_id = #{user_id} #{roomStr} #{buildingStr}").order(building_id: :asc, id: :asc)
  end

  def self.search_room(user_id, name, room_type, status)
    nameStr = ""
    if name != ""
      nameStr = " AND rooms.name = #{name}"
    end

    # typeStr = ""
    # if room_type != ""
    #   typeStr = " AND rooms.type = #{room_type}"
    # end
    #
    # statusStr = ""
    # if status != ""
    #   statusStr = " AND rooms.status = #{status}"
    # end

    select("rooms.*").joins("WHERE rooms.user_id = #{user_id} #{nameStr}")
  end

  def self.search(search)
    search ? where("name LIKE ?", "%#{search[:name]}%") : all
  end

  def self.search_by_building(search)
   if !search[:building].nil?
    where(:building_id => "#{search[:building]}")
   else
    all
   end
  end
end