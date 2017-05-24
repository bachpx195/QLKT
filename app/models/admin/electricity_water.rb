class Admin::ElectricityWater < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates_numericality_of :start_water, :end_water, :start_electricity, :end_electricity, :total_water, :total_electricity, :only_integer => true, :greater_than_or_equal_to => 0, allow_nil: true

  # def self.search(search)
  #   search ? where("1=1 OR building_id LIKE ? OR room_id LIKE ? OR year = ? OR month = ?", "#{search[:building]}", "#{search[:room]}", "#{search[:year]}", "#{search[:month]}") : all
  # end

  def self.search(search)
    strMonthYear = search[:month_year]
    month = strMonthYear.split('/').first
    year = strMonthYear.split('/').last
    search ? where("month = ? AND year = ?",  month, year) : all
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |config|
        csv << config.attributes.values_at(*column_names)
      end
    end
  end

  def month_year
    "#{month}" + "/" + "#{year}"
  end

  def self.search_by_month_year(search)
    if search != nil
      strMonthYear = search[:month_year]
      month = strMonthYear.split('/').first
      year = strMonthYear.split('/').last
      where(:year => year, :month => month)
    else
      all
    end
  end


  def self.search_by_building(search)
    if search!= nil
      Admin::Building.where(:building => "#{search[:building]}")
    else
      all
    end
  end

  def self.search_by_room(search)
    if search != nil
      where(:room => "#{search[:room]}")
    else
      all
    end
  end

  def self.search_ew_by_room(admin_rooms)
    where(:room_id =>  admin_rooms.map(&:id))
  end

end

