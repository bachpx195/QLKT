class Admin::RoomStatistic < Admin::Room
  scope :status, -> (status) { where status: status }
  scope :building, -> (building) { where building: building }
  scope :room_type, -> (room_type) { where room_type: room_type }

  def self.prepair_condition(range)
    case range
       when 1.to_s
         where("cost >= ? AND cost <= ?", 0, 2000000)
       when 2.to_s
         where("cost >= ? AND cost <= ?", 2000000, 5000000)
       when 3.to_s
         where("cost >= ?", 5000000)
      else
        where("cost >= ?", 0)
    end
  end
end
