class Admin::ConfigCategory < ApplicationRecord
  has_many :configs

  validates :name, presence: true, length: { maximum: 255 }
  validates :value, presence: true, length: { maximum: 255 }

  def self.search(search)
    search ? where("name LIKE ?", "%#{search[:name]}%") : all
  end
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |config|
        csv << config.attributes.values_at(*column_names)
      end
    end
  end

end
